

set -ex



pip check
pytest -k test_index_on_single_subdir_1
exit 0
