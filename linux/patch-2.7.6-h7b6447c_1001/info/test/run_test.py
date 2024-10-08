#  tests for patch-2.7.6-h7b6447c_1001 (this is a generated file);
print('===== testing package: patch-2.7.6-h7b6447c_1001 =====');
print('running run_test.py');
#  --- run_test.py (begin) ---
import subprocess

import sys

command = 'patch'

subprocess.check_call([command, '-i', "testfile.patch"])
with open("testfile") as f1:
    testfile1 = f1.read()
with open("testfile2") as f2:
    testfile2 = f2.read()

assert testfile1 == testfile2
#  --- run_test.py (end) ---

print('===== patch-2.7.6-h7b6447c_1001 OK =====');
