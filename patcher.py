import filecmp, argparse, os, numpy

def equal(f1, f2):
    x1, x2 = numpy.fromfile(f1, numpy.int8), numpy.fromfile(f2, numpy.int8)
    return numpy.array_equal(x1, x2)

############################################################################################

parser = argparse.ArgumentParser(description='Copy the files that were updated in folderNew')
parser.add_argument('old_dir', type=str,
                    help='Directory with an old version')

parser.add_argument('new_dir', type=str,
                    help='Directory with a new version')

parser.add_argument('write_dir', type=str,
                    help='Directory where the difference would be written')

args = parser.parse_args()

for (dirpath, dirnames, filenames) in os.walk(args.new_dir):
    for filename in filenames:
        fname = os.sep.join([dirpath, filename])
        cp = os.path.commonprefix([args.new_dir, fname])
        fname = fname[ len(cp)+1: ]

        fold = os.sep.join( [args.old_dir, fname] )
        fnew = os.sep.join( [args.new_dir, fname] )
        #if not os.path.exists(fold) or ( os.path.islink(fnew) and os.readlink(fold) != os.readlink(fnew) ) or not cmp(fnew, fold):

        isdiff = False
        if os.path.islink(fnew):
            try:
                if os.readlink(fold) != os.readlink(fnew):
                    isdiff = True
            except:
                isdiff = True # link fold is absent
        elif not os.path.exists(fold) or not equal(fnew, fold):
            isdiff = True

        if isdiff:
            print fname
            print fnew, fold
            fcp = os.sep.join( [args.write_dir, fname] )
            dcp = os.path.dirname(fcp)
            #print fcp, dcp
            if not os.path.exists(dcp):
                os.makedirs(dcp, 0755)
            os.system("cp -p " + fnew + " " + fcp)
