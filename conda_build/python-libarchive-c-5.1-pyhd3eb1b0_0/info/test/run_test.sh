

set -ex



python -c "import libarchive; libarchive.extract_file('test/hello_world.xar')"
python -c "import os, shutil, libarchive; shutil.copytree(os.path.dirname(libarchive.__file__), 'libarchive')"
pytest -vv --cov libarchive --cov-report term-missing:skip-covered --cov-fail-under=83 -k "not unicode_entries"
exit 0
