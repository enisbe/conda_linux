@echo on

%PYTHON% -m pip install . --no-deps --no-build-isolation ^
        --global-option="--with-libyaml" ^
        --global-option="build_ext" ^
        --global-option="-I%LIBRARY_INC%" ^
        --global-option="-L%LIBRARY_LIB%"