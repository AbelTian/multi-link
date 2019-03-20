#------------------------------------------------------------------------------------------------
#add_sdk_3rdparty.pri
#lib deploy 3rdparty functions
#
#依赖add_version.pri里设置的version。
#依赖add_platform.pri里的QSYS变量和路径
#依赖add_multi_link_technology.pri里面的三大路径
#依赖add_function.pri
#
#please don't modify this pri
#------------------------------------------------------------------------------------------------
#2019-03-19 15:59:29
#发布LIB库的依赖。类似于app工程add_deploy_library的功能，其实只有macOS下有用。
#add_sdk_3rdparty
#add_sdk_3rdparty_bundle

#2019-03-20 09:53:02
#如何加入到add_deploy_library()函数里面呢？
#用户需要在链接环的add_deploy_library_xxxlib()函数里面调用，可是，如果直接写过去，当然可以，可是，那些都是工具生成的，用一个函数最好了。可是，如何合并为一个函数呢？

ADD_SDK_3RDPARTY_PRI_PWD = $${PWD}


################################################
##lib 3rdparty library deploy functions
##内部实现
################################################

###############################################################
#app的发布library命令函数
###############################################################
#app发布lib到自己的目标里，必须先发布app，如果没有先发布app会出错（macOS）。
#lib发布lib，没有的事情
#解释，过去从sdk到build到deploy，现在从sdk到build，从sdk到deploy
defineReplace(get_add_sdk_3rdparty_on_mac) {
    isEmpty(1): error("get_add_sdk_3rdparty_on_mac(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_sdk_3rdparty_on_mac(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)


    command =

    #sdk build station
    #更改lib bundle链接Lib的位置。
    contains(CONFIG, lib_bundle) {
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes no \
            $${APP_BUILD_PWD}/$${TARGET}.framework/Versions/$${VER_MAJ}/$${TARGET} &&
    } else {
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes no \
            $${APP_BUILD_PWD}/lib$${TARGET}.dylib &&
    }

    #sdk deploy repo
    #更改lib bundle链接Lib的位置。
    contains(CONFIG, lib_bundle) {
        #OK?
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes no \
            $${APP_DEPLOY_PWD}/$${TARGET_NAME}.framework/Versions/$${VER_MAJ}/$${TARGET} &&
    } else {
        #OK?
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes no \
            $${APP_DEPLOY_PWD}/lib$${TARGET}.dylib &&
    }

    command += echo . #app deploy library $$librealname progressed.
    #message($$command)

    return ($$command)
}

defineReplace(get_add_sdk_3rdparty_bundle_on_mac) {
    isEmpty(1): error("get_add_sdk_3rdparty_bundle_on_mac(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_sdk_3rdparty_bundle_on_mac(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)


    #这里有个bug，用户删除了SDK以后，App qmake阶段读取这个SDK，结果读到这个位置，为0...bug，其实不应该为0，应该为用户设置的SDK版本号。
    #解决方法一：忽略第一遍编译。也就是什么SDK都没有的时候，编译一遍，lib生成了SDK，可是不管他，再qmake后编译一遍。能解决。
    #解决方法二：$(readlink $${LIB_LIB_PWD}/$${libname}.framework/Versions/Current)，在Makefile处理的时候调用。经过测试，libmajorver没有被赋值为求值命令，所以这个办法不行。
    #解决方法三：这个readlink的过程交给shell解决，包括后边的install_name_tool，OK，解决。
    libmajorver =
    libmajorver = $$system(readlink $${LIB_LIB_PWD}/$${libname}.framework/Versions/Current)
    #libmajorver = $(readlink $${LIB_LIB_PWD}/$${libname}.framework/Versions/Current)
    #这里是以防万一lib不存在 但是不能退出？如果是subdirs包含Library的工程，就不能退出。
    isEmpty(libmajorver){
        libmajorver=0
        message($$TARGET sdk 3rdparty $$libname"," unexisted lib.)
        message($$TARGET first-time bug has been fixed"," wont exit.)
        #return ("echo unexisted lib $$libname .")
    }

    command =

    #更改lib bundle链接Lib的位置。
    contains(CONFIG, lib_bundle) {
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes yes \
            $${APP_BUILD_PWD}/$${TARGET}.framework/Versions/$${VER_MAJ}/$${TARGET} &&
    } else {
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes yes \
            $${APP_BUILD_PWD}/lib$${TARGET}.dylib &&
    }

    #更改lib bundle链接Lib的位置。
    contains(CONFIG, lib_bundle) {
        #OK?
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes yes \
            $${APP_DEPLOY_PWD}/$${TARGET_NAME}.framework/Versions/$${VER_MAJ}/$${TARGET} &&
    } else {
        #OK?
        command += chmod +x $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh &&
        command += . $${ADD_SDK_3RDPARTY_PRI_PWD}/mac_install_name_tool2.sh \
            $${LIB_LIB_PWD} $${libname} $${librealname} yes yes \
            $${APP_DEPLOY_PWD}/lib$${TARGET}.dylib &&
    }

    command += echo . #app deploy library $$librealname progressed.
    #message($$command)

    return ($$command)
}

defineReplace(get_add_sdk_3rdparty_on_windows) {
    isEmpty(1): error("get_add_sdk_3rdparty_on_windows(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_sdk_3rdparty_on_windows(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    DEPLOYTYPE =
    equals(BUILD, Debug):DEPLOYTYPE = --debug
    else:equals(BUILD, Release):DEPLOYTYPE = --release
    else:DEPLOYTYPE = --release

    command =
    command += $$RM $${APP_BUILD_PWD}\\*$${librealname}.* $$CMD_SEP
    #build的地方调试需要.lib等其他文件
    command += $$COPY_DIR $${LIB_LIB_PWD}\\*$${librealname}.* $${APP_BUILD_PWD} $$CMD_SEP
    #拷贝sdk到build
    command += $$COPY_DIR $${LIB_BIN_PWD}\\*$${librealname}.* $${APP_BUILD_PWD} $$CMD_SEP


    command += $$RM $${APP_DEPLOY_PWD}\\*$${librealname}.* $$CMD_SEP
    #deploy的地方不需要.lib等文件
    #拷贝sdk到deploy
    command += $$COPY_DIR $${LIB_BIN_PWD}\\*$${librealname}.* $${APP_DEPLOY_PWD} $$CMD_SEP

    #经过调试发现，如果DLL引用了Qt库，App却没有引用，windeployqt不会发布那些库，在这里发布。
    command += windeployqt $${APP_DEPLOY_PWD}\\$${librealname}.dll $${DEPLOYTYPE} -verbose=1 $$CMD_SEP
    command += windeployqt $${APP_DEPLOY_PWD}\\lib$${librealname}.dll $${DEPLOYTYPE} -verbose=1 $$CMD_SEP

    command += echo . #app deploy library $$librealname progressed.

    #message($$command)

    return ($$command)
}

defineReplace(get_add_sdk_3rdparty_on_linux) {
    isEmpty(1): error("get_add_sdk_3rdparty_on_linux(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_sdk_3rdparty_on_linux(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)


    command =

    command += $$RM $${APP_BUILD_PWD}/lib$${librealname}.so* $$CMD_SEP
    command += $$COPY_DIR $${LIB_LIB_PWD}/lib$${librealname}.so* $${APP_BUILD_PWD} $$CMD_SEP

    command += $$RM $${APP_DEPLOY_PWD}/lib$${librealname}.so* $$CMD_SEP
    command += $$COPY_DIR $${LIB_LIB_PWD}/lib$${librealname}.so* $${APP_DEPLOY_PWD} $$CMD_SEP

    command += echo . #app deploy library $$librealname progressed.

    #message($$command)

    return ($$command)
}

defineReplace(get_add_sdk_3rdparty_on_android) {
    isEmpty(1): error("get_add_sdk_3rdparty_on_android(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("get_add_sdk_3rdparty_on_android(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)

    LIB_ANDROID_PATH = $${LIB_LIB_PWD}/lib$${librealname}.so
    equals(QMAKE_HOST.os, Windows) {
        LIB_ANDROID_PATH~=s,/,\\,g
    }
    message(Android target $${ANDROID_TARGET_ARCH})
    message(Android $${TARGET} sdk 3rdparty library $${LIB_ANDROID_PATH})

    command =
    command += $${LIB_ANDROID_PATH}
    #message($$command)

    return ($$command)
}

################################################
##用户调用
################################################
##以下函数是对add_deploy_library系列函数的补充。
##写在这里是为了说明，这些补充函数是针对Lib工程，发布SDK时用的，发布第三方库。
##事实上多数没有操作，只有macOS下，有一些操作。

#为SDK发布第三方依赖
#一般是不会做这一步的，但是如果必要，那么可以在这里完成，
#一定是为动态链接形式发布的依赖库
#这个时候，SDK已经发布完毕，SDK有依赖项，

#macOS bundle 需要 install_name_tool；非bundle，需要install_name_tool。可选拷贝。
#windows 可选拷贝
#linux 可选拷贝
#Android 可选拷贝
#一般没有拷贝

#参数1 library 依赖库的 libgroupname
#参数2 libname
#参数3 librealname
defineTest(add_sdk_3rdparty) {
    isEmpty(1): error("add_sdk_3rdparty(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_sdk_3rdparty(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)


    #起始位置 编译位置 中间目标位置
    APP_BUILD_PWD=$${DESTDIR}
    isEmpty(APP_BUILD_PWD):APP_BUILD_PWD=.

    appgroupname=$${TARGET_NAME}
    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):appgroupname=$${LIB_SDK_TARGET_NAME}

    #set app deploy pwd
    #APP_DEPLOY_PWD is here.
    APP_DEPLOY_PWD = $${APP_DEPLOY_ROOT}/$${appgroupname}/$${QAPP_STD_DIR}
    #不仅仅发布目标为Windows的时候，才需要改变路径
    #开发机为Windows就必须改变。
    #contains(QKIT_PRIVATE, WIN32||WIN64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_DEPLOY_PWD~=s,/,\\,g
    }

    LIB_STD_DIR =
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    LIB_BIN_PWD = $${LIB_SDK_PWD}/bin
    LIB_LIB_PWD = $${LIB_SDK_PWD}/lib

    equals(QMAKE_HOST.os, Windows) {
        LIB_STD_DIR~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g
        LIB_BIN_PWD~=s,/,\\,g
        LIB_LIB_PWD~=s,/,\\,g
    }

    contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        #发布windows版本
        #!isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        #QMAKE_POST_LINK += $$get_add_sdk_3rdparty_on_windows($${libgroupname}, $${libname}, $${librealname})
    } else: contains(QSYS_PRIVATE, macOS) {
        #发布苹果版本，iOS版本也是这个？
        !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        QMAKE_POST_LINK += $$get_add_sdk_3rdparty_on_mac($${libgroupname}, $${libname}, $${librealname})
    } else: contains(QSYS_PRIVATE, iOS|iOSSimulator) {
        #dynamic link steps
    } else: contains(QSYS_PRIVATE, Android||AndroidX86) {
        #Qt做了。Qt自动生成apk，自动拷贝添加依赖库
        #ANDROID_EXTRA_LIBS += $$get_add_sdk_3rdparty_on_android($${libgroupname}, $${libname}, $${librealname})
        #export(ANDROID_EXTRA_LIBS)
    } else {
        ##发布linux、e-linux，这个是一样的。GG
        #!isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        #QMAKE_POST_LINK += $$get_add_sdk_3rdparty_on_linux($${libgroupname}, $${libname}, $${librealname})
    }

    export(QMAKE_POST_LINK)

    message("$${TARGET} has sdk 3rdparty library $${libname} ")
    return (1)
}

defineTest(add_sdk_3rdparty_bundle) {
    isEmpty(1): error("add_sdk_3rdparty_bundle(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_sdk_3rdparty_bundle(libgroupname, libname, librealname) requires at most three argument")

    libgroupname = $$1
    libname = $$2
    librealname = $$3

    isEmpty(libname): libname = $${libgroupname}
    #建议使用默认值
    isEmpty(librealname): librealname = $$add_decorate_target_name($$libname)


    #起始位置 编译位置 中间目标位置
    APP_BUILD_PWD=$${DESTDIR}
    isEmpty(APP_BUILD_PWD):APP_BUILD_PWD=.

    appgroupname=$${TARGET_NAME}
    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):appgroupname=$${LIB_SDK_TARGET_NAME}

    #set app deploy pwd
    #APP_DEPLOY_PWD is here.
    APP_DEPLOY_PWD = $${APP_DEPLOY_ROOT}/$${appgroupname}/$${QAPP_STD_DIR}
    #不仅仅发布目标为Windows的时候，才需要改变路径
    #开发机为Windows就必须改变。
    #contains(QKIT_PRIVATE, WIN32||WIN64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_DEPLOY_PWD~=s,/,\\,g
    }

    LIB_STD_DIR =
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    LIB_BIN_PWD = $${LIB_SDK_PWD}/bin
    LIB_LIB_PWD = $${LIB_SDK_PWD}/lib

    equals(QMAKE_HOST.os, Windows) {
        LIB_STD_DIR~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g
        LIB_BIN_PWD~=s,/,\\,g
        LIB_LIB_PWD~=s,/,\\,g
    }

    contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        #发布windows版本
        #!isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        #QMAKE_POST_LINK += $$get_add_sdk_3rdparty_on_windows($${libgroupname}, $${libname}, $${librealname})
    } else: contains(QSYS_PRIVATE, macOS) {
        #发布苹果版本，iOS版本也是这个？
        !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        QMAKE_POST_LINK += $$get_add_sdk_3rdparty_bundle_on_mac($${libgroupname}, $${libname}, $${librealname})
    } else: contains(QSYS_PRIVATE, iOS|iOSSimulator) {
        #dynamic link steps
    } else: contains(QSYS_PRIVATE, Android||AndroidX86) {
        #ANDROID_EXTRA_LIBS += $$get_add_sdk_3rdparty_on_android($${libgroupname}, $${libname}, $${librealname})
        #export(ANDROID_EXTRA_LIBS)
    } else {
        ##发布linux、e-linux，这个是一样的。GG
        #!isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
        #QMAKE_POST_LINK += $$get_add_sdk_3rdparty_on_linux($${libgroupname}, $${libname}, $${librealname})
    }

    export(QMAKE_POST_LINK)

    message("$${TARGET} has sdk 3rdparty library $${libname}")
    return (1)
}
