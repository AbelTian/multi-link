#!/usr/bin/env bash
libpwd=$1
libname=$2
librealname=$3

app_bundle=$4
lib_bundle=$5
appname=$6

########################start lib name######################
libfindname=${libname}.*dylib
libsourcename=$(otool -L ${appname} | grep -i ${libfindname} | awk -F' ' '{ print  $1 }')


#######################end lib name################
libmajorver=1
if [ "${lib_bundle}" = "yes" ]; then
    libmajorver=$(readlink ${libpwd}/${libname}.framework/Versions/Current)
fi

libtargetname=lib${librealname}.dylib
if [ "${lib_bundle}" = "yes" ]; then
    libtargetname=${libname}.framework/Versions/${libmajorver}/${librealname}
fi

##############################app bundle settings################
#find_path="@executable_path"
find_path="@rpath"
if [ "${app_bundle}" = "yes" ]; then
    find_path="@rpath"
fi

##############################install name tool#########################
#echo readlink ${libpwd}/${libname}.framework/Versions/Current
#echo
install_name_tool -change ${libsourcename} ${find_path}/${libtargetname} ${appname}

