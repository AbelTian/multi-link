#!/usr/bin/env bash
libpwd=$1
libname=$2
librealname=$3

app_bundle=$4
lib_bundle=$5
appname=$6

libmajorver=1
if [ "${lib_bundle}" = "yes" ]; then
    libmajorver=$(readlink ${libpwd}/${libname}.framework/Versions/Current)
fi

libfindname=${libname}.*dylib
libsourcename=$(otool -L ${appname} | grep -i ${libfindname} | awk -F' ' '{ print  $1 }')

libtargetname=lib${librealname}.dylib
if [ "${lib_bundle}" = "yes" ]; then
    libtargetname=${libname}.framework/Versions/${libmajorver}/${librealname}
fi

find_path="@rpath"
if [ "${app_bundle}" = "no" ]; then
    find_path="@executable_path"
fi

#echo readlink ${libpwd}/${libname}.framework/Versions/Current
#echo
install_name_tool -change ${libsourcename} ${find_path}/${libtargetname} ${appname}

