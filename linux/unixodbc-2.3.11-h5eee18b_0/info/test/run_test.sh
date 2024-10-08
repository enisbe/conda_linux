

set -ex



test -f $PREFIX/lib/libodbc.so.2.0.0
test -f $PREFIX/lib/libodbc.so
test -f $PREFIX/lib/libodbcinst.so.2.0.0
test -f $PREFIX/lib/libodbcinst.so
isql --help
iusql --help
exit 0
