



python -c "import libarchive; libarchive.extract_file('test/hello_world.xar')"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import os, shutil, libarchive; shutil.copytree(os.path.dirname(libarchive.__file__), 'libarchive')"
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest -vv --cov libarchive --cov-report term-missing:skip-covered --cov-fail-under=83 -k "not unicode_entries"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
