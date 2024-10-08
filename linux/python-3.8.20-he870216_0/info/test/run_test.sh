

set -ex



python -V
python3 -V
2to3 -h
pydoc -h
python3-config --help
python -m venv test-venv
python -c "import sysconfig; print(sysconfig.get_config_var('CC'))"
_CONDA_PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata_x86_64_conda_cos6_linux_gnu python -c "import sysconfig; print(sysconfig.get_config_var('CC'))"
for f in ${CONDA_PREFIX}/lib/python*/_sysconfig*.py; do echo "Checking $f:"; if [[ `rg @ $f` ]]; then echo "FAILED ON $f"; cat $f; exit 1; fi; done
test ! -f ${PREFIX}/lib/libpython${PKG_VERSION%.*}.a
test ! -f ${PREFIX}/lib/libpython${PKG_VERSION%.*}.nolto.a
pushd tests
pushd distutils
python setup.py install -v -v
python -c "import foobar"
popd
pushd distutils.cext
python setup.py build_ext -v -v
pushd build/lib*/
python -c "import greet; greet.greet('Python user')" | rg "Hello Python"
popd
popd
pushd prefix-replacement
bash build-and-test.sh
popd
pushd cmake
cmake -GNinja -DPY_VER=3.8.20
popd
popd
python -c "import ssl; assert '3.0' in ssl.OPENSSL_VERSION"
exit 0
