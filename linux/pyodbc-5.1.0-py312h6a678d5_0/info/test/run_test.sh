

set -ex



pip check
python -c "import pyodbc; print('\n'.join(sorted(pyodbc.drivers())))"
exit 0
