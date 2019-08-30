#-------------------------------------------------------------
#add_library.pri
#提供app链接library函数，app lib工程通用

#依赖add_multi_link_technology.pri
#依赖add_platform.pri
#依赖add_project.pri

#please don't modify this pri
#-------------------------------------------------------------
#add_include
#add_include_bundle
#add_library
#add_library_bundle
#add_link_library
#add_link_library_bundle
#add_library_path
#add_header_path
#add_binary_path
#add_libexec_path

#固定SDK结构！请参照add_sdk.pri

################################################################################
#内部用函数
#获取命令
################################################################################
ADD_LIBRARY_PRI_PWD = $${PWD}

##----------------------------------------------------------------------------
#dynamic lib project
#fix macos install_name_tool
##----------------------------------------------------------------------------
#这个是有情况的
#不能放在add_library里，因为后来的add_sdk对build有一次fix，在那次fix之前的操作都无效，
#不能放在add_dependent_manager里，原因同上，
#放在add_sdk之前，就是不行的，必须放在fix之后，
#放在add_sdk之后，那么链接了哪个库就fix哪个库，而且必须fix build和sdk两个位置。
#这样，用户需要add_dependent_manager之后，add_sdk之后，再调用add_fix_dependent_on_mac(xxxlibgroupname, xxxlib, xxxlibrealname)
#话说，fix都是一些拷贝工作，不会影响前边的install_name_tool工作。
#所以，放在add_library里，
#在苹果系统上，用户也只需要add_dependent_manager就能成功链接上第三方库，并且当前库给别的应用当依赖也不会有错误。

#link none bundle library.
defineReplace(get_add_library_fix_macos_install_name_tool) {
    isEmpty(1): error("get_add_library_fix_macos_install_name_tool(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_library_fix_macos_install_name_tool(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    LIB_PROJ_BUILD_PWD=$${DESTDIR}
    isEmpty(LIB_PROJ_BUILD_PWD):LIB_PROJ_BUILD_PWD=.

    LIBRARY_STD_DIR =
    LIBRARY_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}
    LIBRARY_SDK_PWD = $${LIB_SDK_ROOT}/$${LIBRARY_STD_DIR}
    LIBRARY_LIB_PWD = $${LIBRARY_SDK_PWD}/lib

    command =

    #有错误，此处链接的dylib带有主版本号 librealname.1.dylib，无奈中...
    contains(CONFIG, lib_bundle) {
        command += install_name_tool -change lib$${librealname}.dylib \
             @rpath/lib$${librealname}.dylib \
             $${LIB_PROJ_BUILD_PWD}/$${TARGET}.framework/Versions/$${APP_MAJOR_VERSION}/$${TARGET} &&
    } else {
        command += install_name_tool -change lib$${librealname}.dylib \
             @rpath/lib$${librealname}.dylib \
             $${LIB_PROJ_BUILD_PWD}/lib$${TARGET}.dylib &&
    }

    command += echo $${TARGET} warning... maybe not fixed. &&
    command += echo $${TARGET} fix dependent location from lib$${librealname}.dylib to @rpath/lib$${librealname}.dylib

    return ($${command})

}

#link bundle library.
defineReplace(get_add_library_bundle_fix_macos_install_name_tool) {
    isEmpty(1): error("get_add_library_bundle_fix_macos_install_name_tool(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_library_bundle_fix_macos_install_name_tool(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    LIB_PROJ_BUILD_PWD=$${DESTDIR}
    isEmpty(LIB_PROJ_BUILD_PWD):LIB_PROJ_BUILD_PWD=.

    LIBRARY_STD_DIR =
    LIBRARY_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}
    LIBRARY_SDK_PWD = $${LIB_SDK_ROOT}/$${LIBRARY_STD_DIR}
    LIBRARY_LIB_PWD = $${LIBRARY_SDK_PWD}/lib

    command =

    #更改lib bundle链接Lib的位置。
    contains(CONFIG, lib_bundle) {
        command += chmod +x $${ADD_LIBRARY_PRI_PWD}/mac_install_name_tool.sh &&
        command += . $${ADD_LIBRARY_PRI_PWD}/mac_install_name_tool.sh \
            $${LIBRARY_LIB_PWD} $${libname} $${librealname} yes \
            $${LIB_PROJ_BUILD_PWD}/$${TARGET}.framework/Versions/$${APP_MAJOR_VERSION}/$${TARGET} &&
    } else {
        command += chmod +x $${ADD_LIBRARY_PRI_PWD}/mac_install_name_tool.sh &&
        command += . $${ADD_LIBRARY_PRI_PWD}/mac_install_name_tool.sh \
            $${LIBRARY_LIB_PWD} $${libname} $${librealname} yes \
            $${LIB_PROJ_BUILD_PWD}/lib$${TARGET}.dylib &&
    }

    command += echo $${TARGET} fix dependent location from $${libname}.framework to @rpath/$${libname}.framework

    return ($${command})
}

#链接库的命令
#从LIB_SDK_ROOT按照标准路径QSYS_STD_DIR链接
#mac下使用bundle
defineReplace(get_add_library_bundle) {
    isEmpty(1): error("get_add_library(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_library(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    CUR_LIB_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/lib
    equals(QMAKE_HOST.os, Windows) {
        CUR_LIB_PWD~=s,/,\\,g
    }

    LINK =
    contains(DEFINES, __DESKTOP_DARWIN__) {
        LINK += -F$${CUR_LIB_PWD}
        LINK += -framework $${libname}
    } else {
        LINK += -L$${CUR_LIB_PWD}
        #win can't with the blank! error: -l QQt
        LINK += -l$${librealname}
    }

    message($${TARGET} link $${librealname} from $$CUR_LIB_PWD)
    return ($${LINK})
}

#忽略mac bundle的add_library
#建议不设置第三个参数
defineReplace(get_add_library) {
    isEmpty(1): error("get_add_library(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_library(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    CUR_LIB_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/lib
    equals(QMAKE_HOST.os, Windows) {
        CUR_LIB_PWD~=s,/,\\,g
    }

    LINK =
    #注意：macOS下使用-L -l...也就是链接.dylib .a
    LINK += -L$${CUR_LIB_PWD}
    #win can't with the blank! error: -l QQt
    LINK += -l$${librealname}

    message($${TARGET} link $${librealname} from $$CUR_LIB_PWD)

    return ($${LINK})
}


defineReplace(get_add_include_bundle) {
    isEmpty(1): error("get_add_include_bundle(libgroupname, libname, libincsubpath) requires at least one argument")
    !isEmpty(4): error("get_add_include_bundle(libgroupname, libname, libincsubpath) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    libincsubpath = $$3

    isEmpty(libname): libname = $${libgroupname}

    CUR_INC_PWD =
    contains(DEFINES, __DESKTOP_DARWIN__) {
        CUR_INC_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/lib/$${libname}.framework/Headers
        !isEmpty(libincsubpath):CUR_INC_PWD=$${CUR_INC_PWD}/$${libincsubpath}
    } else {
        CUR_INC_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/include/$${libname}
        !isEmpty(libincsubpath):CUR_INC_PWD=$${CUR_INC_PWD}/$${libincsubpath}
        equals(QMAKE_HOST.os, Windows) {
            CUR_INC_PWD~=s,/,\\,g
        }
    }

    INCLUDE =
    INCLUDE += $${CUR_INC_PWD}
    message ($${TARGET} include $${CUR_INC_PWD})

    return ($${INCLUDE})
}

#获取头文件路径
defineReplace(get_add_include) {
    isEmpty(1): error("get_add_include(libgroupname, libname, libincsubpath) requires at least one argument")
    !isEmpty(4): error("get_add_include(libgroupname, libname, libincsubpath) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    libincsubpath = $$3

    isEmpty(libname): libname = $${libgroupname}

    CUR_INC_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/include/$${libname}
    !isEmpty(libincsubpath):CUR_INC_PWD=$${CUR_INC_PWD}/$${libincsubpath}
    equals(QMAKE_HOST.os, Windows) {
        CUR_INC_PWD~=s,/,\\,g
    }

    INCLUDE =
    INCLUDE += $${CUR_INC_PWD}
    message ($${TARGET} include $${CUR_INC_PWD})

    return ($${INCLUDE})
}

#添加链接库路径 Only 路径
defineReplace(get_add_library_path) {
    isEmpty(1)|!isEmpty(2): error("get_add_library_path(libgroupname) requires one argument")

    libgroupname = $$1
    CUR_LIB_PWD = $${LIB_SDK_ROOT}/$${libgroupname}/$${QSYS_STD_DIR}/lib
    equals(QMAKE_HOST.os, Windows) {
        CUR_LIB_PWD~=s,/,\\,g
    }

    LIBRARYPATH =
    LIBRARYPATH += $${CUR_LIB_PWD}

    message($${TARGET} add library path $${LIBRARYPATH})

    return ($${LIBRARYPATH})
}

################################################################################
#公开给外部用函数
#执行命令
################################################################################
#包含路径
#包含library
defineTest(add_library) {
    isEmpty(1): error("add_library(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_library(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    command =
    command += $$get_add_library($${libgroupname}, $${libname}, $${librealname})
    LIBS += $${command}
    export(LIBS)
    #message (LIBS += $$command)

    contains(QSYS_PRIVATE, macOS) : contains(TEMPLATE, lib) : contains(CONFIG, dll) {
        !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        QMAKE_POST_LINK += $$get_add_library_fix_macos_install_name_tool($${libgroupname}, $${libname}, $${librealname})
        export(QMAKE_POST_LINK)
    }


    return (1)
}

defineTest(add_library_bundle) {
    isEmpty(1): error("add_library_bundle(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_library_bundle(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    command =
    command += $$get_add_library_bundle($${libgroupname}, $${libname}, $${librealname})
    LIBS += $${command}
    export(LIBS)
    #message (LIBS += $$command)

    contains(QSYS_PRIVATE, macOS) : contains(TEMPLATE, lib) : contains(CONFIG, dll) {
        !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        QMAKE_POST_LINK += $$get_add_library_bundle_fix_macos_install_name_tool($${libgroupname}, $${libname}, $${librealname})
        export(QMAKE_POST_LINK)
    }

    return (1)
}

defineTest(add_include_bundle) {
    isEmpty(1): error("add_include_bundle(libgroupname, libname, libincsubpath) requires at least one argument")
    !isEmpty(4): error("add_include_bundle(libgroupname, libname, libincsubpath) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    libincsubpath = $$3

    isEmpty(libname): libname = $${libgroupname}

    command = $$get_add_include_bundle($$libgroupname, $$libname, $$libincsubpath)
    INCLUDEPATH += $${command}
    export(INCLUDEPATH)
    #message (INCLUDEPATH += $$command)

    return (1)
}

defineTest(add_include) {
    isEmpty(1): error("add_include(libgroupname, libname, libincsubpath) requires at least one argument")
    !isEmpty(4): error("add_include(libgroupname, libname, libincsubpath) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    libincsubpath = $$3

    isEmpty(libname): libname = $${libgroupname}

    command = $$get_add_include($$libgroupname, $$libname, $$libincsubpath)
    INCLUDEPATH += $${command}
    export(INCLUDEPATH)
    #message (INCLUDEPATH += $$command)

    return (1)
}

defineTest(add_library_path) {
    isEmpty(1)|!isEmpty(2): error("add_library_path(libgroupname) requires one argument")

    libgroupname = $$1
    librarypath = $$get_add_library_path($${libgroupname})

    command =
    contains(DEFINES, __DESKTOP_DARWIN__) {
        command += -F$${librarypath}
    }
    command += -L$${librarypath}

    LIBS += $$command
    export(LIBS)

    return (1)
}


#链接标准SDK
defineTest(add_link_library) {
    isEmpty(1): error("add_link_library(libgroupname, libname) requires at least one argument")
    !isEmpty(3): error("add_link_library(libgroupname, libname) requires at most two argument")

    libgroupname = $$1
    libname = $$2

    isEmpty(libname): libname = $${libgroupname}

    add_include($${libgroupname}, $$libname)
    add_library($$libgroupname, $$libname)

    return (1)
}

defineTest(add_link_library_bundle) {
    isEmpty(1): error("add_link_library_bundle(libgroupname, libname) requires at least one argument")
    !isEmpty(3): error("add_link_library_bundle(libgroupname, libname) requires at most two argument")

    libgroupname = $$1
    libname = $$2

    isEmpty(libname): libname = $${libgroupname}

    add_include_bundle($${libgroupname}, $$libname)
    add_library_bundle($$libgroupname, $$libname)

    return (1)
}
