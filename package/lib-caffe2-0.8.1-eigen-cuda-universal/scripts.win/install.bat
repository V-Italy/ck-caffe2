@echo off

rem
rem Installation script for CK packages.
rem
rem See CK LICENSE.txt for licensing details.
rem See CK Copyright.txt for copyright details.
rem
rem Developer(s): Grigori Fursin, 2017
rem

rem PACKAGE_DIR
rem INSTALL_DIR

rem get eigen and protobuf
cd /d %INSTALL_DIR%\src

rem Get protobuf from CK and copy here
if exist "%CK_ENV_LIB_PROTOBUF_HOST_SRC_DIR%" (
 xcopy /s /e /y %CK_ENV_LIB_PROTOBUF_HOST_SRC_DIR%\* third_party\protobuf\
)

if exist "%CK_ENV_LIB_PROTOBUF_HOST%" (
 if not exist "build_host_protoc" (
   mkdir build_host_protoc
 )
 xcopy /s /e /y %CK_ENV_LIB_PROTOBUF_HOST%\* build_host_protoc\
)

rem git submodule update --init -- third_party\protobuf

if "%CAFFE_BUILD_PYTHON%" == "ON" (
  echo.
  echo You are compiling Caffe2 with Python support!
  echo To use it you need to set up CK env as following ^(after installation^)^:
  echo.
  echo "ck xset env tags=lib,caffe2 & call tmp-ck-env.bat & ipython2"
  echo.
  set /p id="Press enter to continue"
)

cd /d %INSTALL_DIR%\obj

echo **************************************************************
echo Preparing vars for Caffe 2 ...

set CK_CXX_FLAGS_FOR_CMAKE=
set CK_CXX_FLAGS_ANDROID_TYPICAL=

set CK_CMAKE_EXTRA=%CK_CMAKE_EXTRA% ^
 -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
 -DCMAKE_VERBOSE_MAKEFILE=1 ^
 -DBUILD_TEST=OFF ^
 -DBLAS=%WHICH_BLAS% ^
 -DUSE_THREADS=%USE_THREADS% ^
 -DUSE_NERVANA_GPU=%USE_NERVANA_GPU% ^
 -DUSE_GLOG=OFF ^
 -DUSE_GFLAGS=OFF ^
 -DUSE_LMDB=OFF ^
 -DUSE_LEVELDB=OFF ^
 -DUSE_LITE_PROTO=%USE_LITE_PROTO% ^
 -DUSE_NCCL=%USE_NCCL% ^
 -DUSE_NNPACK=%USE_NNPACK% ^
 -DUSE_OPENCV=OFF ^
 -DUSE_CUDA=%USE_CUDA% ^
 -DUSE_CNMEM=%USE_CNMEM% ^
 -DUSE_ZMQ=%USE_ZMQ% ^
 -DUSE_ROCKSDB=%USE_ROCKSDB% ^
 -DUSE_REDIS=%USE_REDIS% ^
 -DUSE_MPI=%USE_MPI% ^
 -DUSE_GLOO=%USE_GLOO% ^
 -DBUILD_SHARED_LIBS=OFF ^
 -DUSE_OPENMP=%USE_OPENMP% ^
 -DBUILD_PYTHON=%CAFFE_BUILD_PYTHON% ^
 -DBUILD_BINARY=OFF ^
 -DBUILD_TEST=%BUILD_TEST% ^
 -DCUDA_TOOLKIT_ROOT_DIR="%CK_ENV_COMPILER_CUDA_WIN%" ^
 -DCUDA_HOST_COMPILER="%VCINSTALLDIR%\cl.exe" ^
 -DCCBIN="%VCINSTALLDIR%\cl.exe" ^
 -DPROTOBUF_PROTOC_EXECUTABLE="%CK_ENV_LIB_PROTOBUF_HOST%\bin\protoc.exe"

rem -DGFLAGS_INCLUDE_DIR="%CK_ENV_LIB_GFLAGS_INCLUDE%" ^
rem -DGFLAGS_LIBRARY_RELEASE="%CK_ENV_LIB_GFLAGS_LIB%\gflags.lib" ^
rem -DGFLAGS_LIBRARY_DEBUG="%CK_ENV_LIB_GFLAGS_LIB%\gflags.lib" ^
rem -DGLOG_INCLUDE_DIR="%CK_ENV_LIB_GLOG_INCLUDE%" ^
rem -DGLOG_LIBRARY_RELEASE="%CK_ENV_LIB_GLOG_LIB%\glog.lib" ^
rem -DGLOG_LIBRARY_DEBUG="%CK_ENV_LIB_GLOG_LIB%\glog.lib" ^
rem -DLMDB_INCLUDE_DIR="%CK_ENV_LIB_LMDB_INCLUDE%" ^
rem -DLMDB_LIBRARIES="%CK_ENV_LIB_LMDB_LIB%\lmdb.lib" ^
rem -DOpenCV_DIR="%CK_ENV_LIB_OPENCV%" ^
rem -DOpenCV_LIB_PATH="%CK_ENV_LIB_OPENCV_LIB%"

rem -DUSE_LMDB=%USE_LMDB% ^


rem -DPROTOBUF_DIR="%CK_ENV_LIB_PROTOBUF_HOST%\cmake" ^
rem -DPROTOBUF_PROTOC_EXECUTABLE="%CK_ENV_LIB_PROTOBUF_HOST%\bin\protoc.exe" ^

rem -DOpenBLAS_INCLUDE_DIR="%CK_ENV_LIB_OPENBLAS_INCLUDE%" ^
rem -DOpenBLAS_LIB="%CK_ENV_LIB_OPENBLAS_LIB%\%CK_ENV_LIB_OPENBLAS_STATIC_NAME%" ^

rem -DBLAS=%WHICH_BLAS% ^

exit /b 0
