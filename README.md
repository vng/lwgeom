# lwgeom
Standalone liblwgeom CMake build with preliminary support for MSVC compiler

# Build
The CMake build is a work in progress and support for additional dependencies will be added if time permits.

## Linux
```
mkdir <build-dir>
cd <build-dir>
cmake .. -DCMAKE_INSTALL_PREFIX=<install-dir>
make
make install
```

## Windows
```
mkdir <build-dir>
cd <build-dir>
cmake .. -G "Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=<install-dir> \
-DBUILD_SHARED_LIBS=OFF -DGEOS_DIR=<geos-install-dir> -DGEOS_USE_STATIC_LIBS=OFF \
-DPROJ_DIR=<proj-install-dir> -DPROJ_USE_STATIC_LIBS=ON \
-DJSON_C_DIR=<jsonc-install-dir> -DJSON_C_USE_STATIC_LIBS=ON
open lwgeom.sln or use msbuild or use devenv.com
```
