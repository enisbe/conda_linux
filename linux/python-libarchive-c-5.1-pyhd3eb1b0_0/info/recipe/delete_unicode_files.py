# Delete some files in this package's test data that have Unicode names, which
# cause problems for older versions of Mamba and possibly other archiving tools.
# We do this with this short Python script because naming the files in Unicode
# in `meta.yaml` in turn causes problems for conda-build on Windows.

import os.path

testdir = os.path.join(os.environ["SRC_DIR"], "tests", "data")

for fname in os.listdir(testdir):
    if not fname.isascii():
        ffull = os.path.join(testdir, fname)
        # On Windows we can't even print these names safely!
        print("- Unlinking", ffull.encode("ascii", errors="replace"))
        os.unlink(ffull)