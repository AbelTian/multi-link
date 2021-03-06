#------------------------------------------------------------------------------------------------
#add_sdk.pri
#making sdk function
#
#install to SDK path
#把Library按照SDK格式安装到LIB_SDK_ROOT
#发布到sdk是为Multi link准备的。
#
#依赖add_version.pri里设置的version。
#依赖add_platform.pri里的QSYS变量和路径
#依赖add_multi_link_technology.pri里面的三大路径
#依赖add_function.pri
#
#please don't modify this pri
#------------------------------------------------------------------------------------------------

##SDK格式
##LibGroupName/Windows/include/libName/***.h
##                    /bin/libName<ver>[d].dll
##                    /lib/libName<ver>[d].a .lib

##LibGroupName/Linux/include/libName/***.h
##                  /bin/
##                  /lib/libName.so.*

##LibGroupName/macOS/include/libName/***.h
##                  /bin/
##                  /lib/libName<ver>.dylib
##                      /libName[_debug].dylib

##LibGroupName/macOS/include/libName/***.h
##                  /bin/
##                  /lib/libName.framework/Headers/***.h
##                                        /libName[_debug]

#固定SDK结构，操作系统中直接使用这个目录结构。
#没有SDK SubDir结构！

################################################
#add_sdk
#add_sdk_to_Qt
#add_sdk_to_Qt_plugins
#add_sdk_header
#add_sdk_header_no_postfix
#add_export (= add_sdk)
#add_header_dir (=add_source_dir)
#add_source_dir
#add_build_dir
#clean_sdk

#2018-11-10 11:32:35
#add_sdk_header 从发布没有后缀的头文件改为发布指定目录的头文件
#add_sdk_header_no_postfix 帮助用户删除头文件后缀，按照指定名称，发布到指定位置

#2019年3月7日 11点04分
#待研究
#QMAKE_LFLAGS_SONAME = -Wl,-install_name,@rpath/Frameworks/
#QMAKE_LFLAGS += -Wl,-rpath,@loader_path/../,-rpath,@executable_path/../
#QMAKE_LFLAGS += -Wl,-Bsymbolic

#2019年3月20日 16点33分
#add_sdk_header_ex 发布指定目录的指定通配后缀名的文件
#add_sdk_header_all 发布指定目录的所有的文件

ADD_SDK_PRI_PWD = $${PWD}

#在build path修复app (macOS专有)
#copy lib
#fix bundle路径链接
#不修复，直接拷贝，所有的快捷方式会丢失，变成实体
#拷贝temp进行修复。
defineReplace(get_add_mac_sdk_fix_building_framework) {
    #这里有特点，framework的名字，一定是TARGET。
    libname = $$TARGET
    #realname也是TARGET
    librealname = $$TARGET
    #废弃以上代码，当然，它是对的，but，固定的。

    libname = $$1
    librealname = $$2
    #isEmpty(1): error("get_add_mac_sdk_fix_building_framework(libname, librealname) requires at last one argument")
    !isEmpty(3): error("get_add_mac_sdk_fix_building_framework(libname, librealname) requires at most two argument")
    isEmpty(1):libname = $$TARGET_NAME
    isEmpty(2): librealname = $${libname}

    libtempname = $${libname}_temp

    command =
    command += chmod +x $${ADD_SDK_PRI_PWD}/linux_cur_path.sh &&
    command += . $${ADD_SDK_PRI_PWD}/linux_cur_path.sh &&

    #create temp
    command += $$MK_DIR $${LIB_BUILD_PWD}/$${libtempname}.framework &&
    #进去
    command += cd $${LIB_BUILD_PWD}/$${libtempname}.framework &&

    #修复framework里的快捷方式
    #need APP_BUILD_PWD
    create_command = $$get_add_mac_sdk($${libname}, $${librealname})
    command += $${create_command} &&

    command += chmod +x $${ADD_SDK_PRI_PWD}/linux_cd_path.sh &&
    command += . $${ADD_SDK_PRI_PWD}/linux_cd_path.sh &&

    #拷贝prl到新的里
    command += $$COPY $${LIB_BUILD_PWD}/$${libname}.framework/$${librealname}.prl $${LIB_BUILD_PWD}/$${libtempname}.framework/$${librealname}.prl $$CMD_SEP

    #del 原先的
    command += $$RM_DIR $${LIB_BUILD_PWD}/$${libname}.framework &&
    #rename 临时的 framework 到原先的
    command += $$MOVE $${LIB_BUILD_PWD}/$${libtempname}.framework $${LIB_BUILD_PWD}/$${libname}.framework

    #message($$command)
    return ($${command})
}


################################################
##lib install functions
##variable can be private and default inherit
##内部实现
################################################
defineReplace(get_add_sdk_dir_struct) {
    #if it's qt library, don't create
    command =
    !equals(LIB_SDK_PWD , $$[QT_INSTALL_DATA]){
        contains(QSYS_PRIVATE, macOS):contains(CONFIG, lib_bundle) {
            #bundle模式没有include目录
        } else {
            command += $$MK_DIR $$LIB_INC_DIR $$CMD_SEP
        }
        command += $$MK_DIR $$LIB_BIN_DIR $$CMD_SEP
        command += $$MK_DIR $$LIB_LIB_DIR $$CMD_SEP
        command += $$MK_DIR $$LIB_CMAKE_DIR $$CMD_SEP
        command += $$MK_DIR $$LIB_PRI_PATH
    }
    return ($$command)
}

defineReplace(get_add_windows_sdk) {
    #need cd sdk root

    command =
    #copy header
    command += $${COPY_DIR} $${LIB_SRC_PWD}\\*.h* $${LIB_INC_DIR} $$CMD_SEP
    #should be *.dll *.lib
    command += $${COPY_DIR} $${LIB_BUILD_PWD}\\* $${LIB_LIB_DIR} $$CMD_SEP
    #move *.dll
    command += $${MOVE} $${LIB_LIB_DIR}\\*.dll $${LIB_BIN_DIR}

    return ($$command)
}

defineReplace(get_add_linux_sdk) {
    #need cd sdk root
    copy_command = $$get_copy_dir_and_file($${LIB_SRC_PWD}, "*.h*", $${LIB_INC_DIR})
    command =
    command += $${copy_command} $$CMD_SEP
    #should be *.so.* *.a
    command += $$COPY_DIR $${LIB_BUILD_PWD}/* $${LIB_LIB_DIR}

    return ($$command)
}

#理论上，只要用户设置了Version，就能读到Version Major
#add_version里面有初始化版本号，所以，用户什么都不设置，将会是0版本号。
#从libname.framework拷贝到当前新建的framework 内部为librealname
defineReplace(get_add_mac_sdk){
    #need cd framework root
    #LIB_BUILD_PWD libname libmajorver
    libname = $$1
    librealname = $$2
    #isEmpty(1): error("get_add_mac_sdk(libname, librealname) requires at last one argument")
    !isEmpty(3): error("get_add_mac_sdk(libname, librealname) requires at most two argument")
    isEmpty(1):libname = $$TARGET_NAME
    isEmpty(2): librealname = $${libname}

    libmajorver = $$VER_MAJ
    isEmpty(libmajorver){
        error(Have you modifyed add_version.pri, please dont modify it.)
    }

    #这里的isEmpty没有用。
    #isEmpty(libmajorver):libmajorver = $$system(readlink $${LIB_BUILD_PWD}/$${libname}.framework/Versions/Current)
    #message($${LIB_BUILD_PWD}/$${libname}.framework/Versions/Current $$TARGET major version $$libmajorver)

    LIB_BUNDLE_VER_DIR   = Versions/$${libmajorver}
    LIB_BUNDLE_CUR_DIR   = Versions/Current
    LIB_BUNDLE_INC_DIR   = $${LIB_BUNDLE_VER_DIR}/Headers
    LIB_BUNDLE_RES_DIR   = $${LIB_BUNDLE_VER_DIR}/Resources
    LIB_BUNDLE_EXE_FILE  = $${LIB_BUNDLE_VER_DIR}/$${librealname}

    LIB_BUNDLE_CUR_INC_DIR   = $${LIB_BUNDLE_CUR_DIR}/Headers
    LIB_BUNDLE_CUR_RES_DIR   = $${LIB_BUNDLE_CUR_DIR}/Resources
    LIB_BUNDLE_CUR_EXE_FILE  = $${LIB_BUNDLE_CUR_DIR}/$${librealname}

    LIB_BUNDLE_CUR_LINK  = Current
    LIB_BUNDLE_INC_LINK  = Headers
    LIB_BUNDLE_RES_LINK  = Resources
    LIB_BUNDLE_EXE_LINK  = $${librealname}

    command =
    command += $$MK_DIR $$LIB_BUNDLE_VER_DIR $$CMD_SEP
    command += $$MK_DIR $$LIB_BUNDLE_INC_DIR $$CMD_SEP
    #copy lib
    #should be *
    command += $$COPY_DIR $${LIB_BUILD_PWD}/$${libname}.framework/$${LIB_BUNDLE_VER_DIR}/* $$LIB_BUNDLE_VER_DIR $$CMD_SEP
    #copy header
    copy_command = $$get_copy_dir_and_file($${LIB_SRC_PWD}, "*.h*", $${LIB_BUNDLE_INC_DIR})
    command += $${copy_command} $$CMD_SEP
    #link header current resources
    command += $$CD Versions $$CMD_SEP
    command += $$LN $${libmajorver} $${LIB_BUNDLE_CUR_LINK} $$CMD_SEP
    command += $$CD .. $$CMD_SEP
    command += $$LN $$LIB_BUNDLE_CUR_INC_DIR  $${LIB_BUNDLE_INC_LINK} $$CMD_SEP
    command += $$LN $$LIB_BUNDLE_CUR_RES_DIR  $${LIB_BUNDLE_RES_LINK} $$CMD_SEP
    command += $$LN $$LIB_BUNDLE_CUR_EXE_FILE $${LIB_BUNDLE_EXE_LINK}
    equals(MULTI_LINK_WITH_QT, true) {
        lessThan(QT_MAJOR_VERSION, 5){
            command += $$CMD_SEP
            command += chmod +x $${ADD_SDK_PRI_PWD}/mac_deploy_qt4.sh $$CMD_SEP
            command += $${ADD_SDK_PRI_PWD}/mac_deploy_qt4.sh $${LIB_BUNDLE_VER_DIR}/$${libname}
        }
    }
    return ($$command)
}

#这个函数是支持发布Qt Library用的，add_sdk用到了。
defineReplace(get_add_Qt_lib_pri){
    #need cd sdk root
    #LIB_BASE_DIR libname LIB_VERSION MODULE_CNAME
    ##write qt_lib_qqtcore.pri

    command =
    command += $$get_empty_file($${LIB_PRI_FILEPATH}) $$CMD_SEP
    command += echo "QT.$${liblowername}.VERSION = $${APP_VERSION}" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT.$${liblowername}.name = $${libname}"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT.$${liblowername}.module = $${libname}"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP

    contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
        command += echo "QT.$${liblowername}.libs = \$$QT_MODULE_LIB_BASE"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.bins = \$$QT_MODULE_BIN_BASE"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    } else {
        command += echo "QT.$${liblowername}.libs = '\$$QT_MODULE_LIB_BASE'"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.bins = '\$$QT_MODULE_BIN_BASE'"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    }

    contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
        command += echo "QT.$${liblowername}.includes = \$$QT_MODULE_INCLUDE_BASE \$$QT_MODULE_INCLUDE_BASE/$${libname}" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.frameworks = " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.module_config = v2 " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    }else:equals(QSYS_PRIVATE, macOS) {
        contains(CONFIG, lib_bundle){
            command += echo "QT.$${liblowername}.includes = '\$$QT_MODULE_LIB_BASE/$${libname}.framework/Headers'"  >> $${LIB_PRI_FILEPATH} $$CMD_SEP
            command += echo "QT.$${liblowername}.frameworks = '\$$QT_MODULE_LIB_BASE'" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
            command += echo "QT.$${liblowername}.module_config = v2 lib_bundle" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        } else {
            command += echo "QT.$${liblowername}.includes = '\$$QT_MODULE_INCLUDE_BASE \$$QT_MODULE_INCLUDE_BASE/$${libname}'" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
            command += echo "QT.$${liblowername}.frameworks = " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
            command += echo "QT.$${liblowername}.module_config = v2 " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        }
    } else {
        command += echo "QT.$${liblowername}.includes = '\$$QT_MODULE_INCLUDE_BASE \$$QT_MODULE_INCLUDE_BASE/$${libname}'" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.frameworks = " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
        command += echo "QT.$${liblowername}.module_config = v2 " >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    }

    lessThan(QT_MAJOR_VERSION, 5):{
        command += echo "QT.$${liblowername}.depends = core sql network gui xml" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    } else {
        command += echo "QT.$${liblowername}.depends = core sql network gui xml widgets" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    }

    command += echo "QT.$${liblowername}.uses =" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    TEMP_TARGET_NAME = $$upper($${TARGET_NAME})
    command += echo "QT.$${liblowername}.DEFINES = $${TEMP_TARGET_NAME}_LIBRARY" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT.$${liblowername}.enabled_features =" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT.$${liblowername}.disabled_features =" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT_CONFIG +=" >> $${LIB_PRI_FILEPATH} $$CMD_SEP
    command += echo "QT_MODULES += $${liblowername}" >> $${LIB_PRI_FILEPATH}

    return ($$command)
}

################################################
##Lib deploy sdk workflow
##SDK发布过程
################################################

defineReplace(get_add_sdk_work_flow){
    #need cd sdk root

    libname = $$1
    librealname = $$2
    #isEmpty(1): error("get_add_sdk_work_flow(libname, librealname) requires at last one argument")
    !isEmpty(3): error("get_add_sdk_work_flow(libname, librealname) requires at most two argument")
    isEmpty(1):libname = $$TARGET_NAME
    isEmpty(2): librealname = $${libname}
    liblowername = $$lower($${librealname})

    command =
    contains(QSYS_PRIVATE, macOS):contains(CONFIG, dll):contains(CONFIG, lib_bundle) {
        #在编译路径里，创作一次sdk，完成framework链接等的修复工作
        command += $$get_add_mac_sdk_fix_building_framework($${librealname}, $${librealname}) $$CMD_SEP
        #command += echo $$libname fix framework success. $$CMD_SEP
    }
    #command += $$RM_DIR $${LIB_SDK_PWD} $$CMD_SEP
    command += $$MK_DIR $${LIB_SDK_PWD} $$CMD_SEP
    command += $$CD $${LIB_SDK_PWD} $$CMD_SEP
    command += $$get_add_sdk_dir_struct() $$CMD_SEP

    #这里不是目标为Windows才拷贝，而是开发机是Windows就得这么拷贝。
    #Windows下，Win目标、Android目标都走这里。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        #message(create lib windows struct library)
        command += $$get_add_windows_sdk() $$CMD_SEP
        contains(CONFIG, create_prl):command += $$COPY $${LIB_BUILD_PWD}\\*.prl lib $$CMD_SEP
    } else {
        #macOS lib_bundle make sdk
        contains(QSYS_PRIVATE, macOS):contains(CONFIG, dll):contains(CONFIG, lib_bundle) {
            #message(create lib mac bundle framework)
            command += $$MK_DIR lib/$${libname}.framework $$CMD_SEP
            command += $$CD lib/$${libname}.framework $$CMD_SEP
            command += $$get_add_mac_sdk($${librealname}, $${librealname}) $$CMD_SEP
            command += $$CD ../../ $$CMD_SEP
            #create prl
            contains(CONFIG, create_prl):command += $$COPY $${LIB_BUILD_PWD}/$${librealname}.framework/$${librealname}.prl lib/$${libname}.framework/$${librealname}.prl $$CMD_SEP
        } else:contains(QSYS_PRIVATE, macOS):contains(CONFIG, static|staticlib) {
            command += $$get_add_linux_sdk() $$CMD_SEP
            #无论如何，macOS下.a是没有lib_bundle的。
            #此处为何添加ranlib -s？为什么会出现这个现象？因为ranlib -s命令，Qt Creator在编译POSTLINK后才执行的，
            #但是这个时候SDK已经生成完毕，所以，Multi-link对SDK .a也追加执行。
            #在这里，增加ranlib命令。SDK ROOT里的macOS .a可以用了。
            command += ranlib -s $${LIB_LIB_DIR}/lib$${librealname}.a $$CMD_SEP
            contains(CONFIG, create_prl):command += $$COPY $${LIB_BUILD_PWD}/*.prl lib $$CMD_SEP
        } else:contains(QSYS_PRIVATE, iOS|iOSSimulator):contains(CONFIG, static|staticlib) {
            #iOS的.a文件，需要ranlib -s。
            #macOS .a 都需要吗? dylib似乎不需要。framework似乎也不需要。bundle似乎也不需要。app似乎也不需要。
            #经过查询，ranlib = ar -s，是所有类Unix系统都需要的。
            #判定条件：不仅仅iOS需要，所有类Unix系统都需要，仅仅针对.a。
            #谁做了谁没做？iOS iOSSimulator没做。macOS? linux e-linux android应该不需要。
            #iOS 8 以后给开发者开放动态库了？企业开发者？好吧，+static
            #好像只有苹果下动态库和静态库生成有一些复杂工作做。苹果操作复杂啊。
            command += $$get_add_linux_sdk() $$CMD_SEP
            #在这里，增加ranlib命令。SDK ROOT里的iOS .a可以用了。
            command += ranlib -s $${LIB_LIB_DIR}/lib$${librealname}.a $$CMD_SEP
            contains(CONFIG, create_prl):command += $$COPY $${LIB_BUILD_PWD}/*.prl lib $$CMD_SEP
        } else {
            #Android在linux开发机下也会走这里，Android目标，Lib可以发布Win和Linux两种格式的SDK。
            #message(create lib linux struct library)
            #macOS no bundle 也会走这里，已经支持非bundle
            command += $$get_add_linux_sdk() $$CMD_SEP
            contains(CONFIG, create_prl):command += $$COPY $${LIB_BUILD_PWD}/*.prl lib $$CMD_SEP
        }
    }

    #fix bug: 从sdk的头文件目录里移除multi-link目录。 Multi-link 2.0
    #用户把multi-link作为submodule的时候，请保证multi-link文件夹的名字为multi-link。
    MULTI_LINK_DIR = $${LIB_INC_DIR}/multi-link
    equals(QMAKE_HOST.os, Windows) {
        #on windows every path must use \ sep.
        MULTI_LINK_DIR~=s,/,\\,g
    }
    #用户需要注意，APP_SOURCE_DIR目录不能包括multi-link目录，建议multi-link和src目录平行放置。
    #这样可以避免SDK里面出现multi-link文件夹。
    #用户应当自行注意工程目录的排布。
    #command += $$RM_DIR $${MULTI_LINK_DIR} $$CMD_SEP

    command += $$get_add_Qt_lib_pri()
    #$$CMD_SEP
    #command += echo $$libname create sdk success.

    return ($$command)
}

################################################
##Lib deploy sdk work flow
##初始化SDK发布过程需要的变量
################################################
defineReplace(get_add_sdk_private){
    #这个判定逻辑只能用于内部，不能用于最外层。
    libname = $$1
    librealname = $$2
    #isEmpty(1): error("get_add_sdk_private(libname, librealname) requires at last one argument")
    !isEmpty(3): error("get_add_sdk_private(libname, librealname) requires at most two argument")
    isEmpty(1):libname = $$TARGET_NAME
    isEmpty(2): librealname = $${libname}
    liblowername = $$lower($${librealname})

    #qqt defined these dir struct, used from qt library
    LIB_INC_DIR = include/$${TARGET_NAME}
    LIB_BIN_DIR = bin
    LIB_LIB_DIR = lib
    LIB_CMAKE_DIR=lib/cmake/$${libname}
    LIB_PRI_PATH=mkspecs/modules
    LIB_PRI_FILEPATH=$${LIB_PRI_PATH}/qt_lib_$${liblowername}.pri

    #不仅仅发布目标为Windows的时候需要改变，
    #开发Host是Windows的时候都要改变。路径问题是两种操作系统固有的痛。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        #on windows every path must use \ sep.
        LIB_SRC_PWD~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_INC_DIR~=s,/,\\,g
        LIB_BIN_DIR = bin
        LIB_LIB_DIR = lib
        LIB_CMAKE_DIR~=s,/,\\,g
        LIB_PRI_PATH~=s,/,\\,g
        LIB_PRI_FILEPATH~=s,/,\\,g

        #ignored
        HEADERS_WIN=$${HEADERS}
        HEADERS_WIN~=s,/,\\,g
        #on windows, copy all *.h*, include closed feature header.
        #qmake regexp use perl grammer
        #HEADERS_WIN~=s/[d ]+/h+/g how to mod space to +
    }
    #create library struct
    #create platform sdk
    #create mkspec module pri
    command = $$get_add_sdk_work_flow($${libname}, $${librealname})

    #message ($$command)
    return ($${command})
}


################################################
##用户调用的函数
################################################

#发布链接库的SDK到SDK仓
#libgroupname <主目录名>
#libname 这里，libname是内定的 就是用户设置的TARGET 没有修饰的那个 如果想发布成随意的样子就改变这个。这个很重要，建议不要随便改动。
#librealname 用户自定义名称，一般省略 = 修饰名是没有问题的。
defineTest(add_sdk){
    #isEmpty(1): error("add_sdk(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_sdk(libgroupname, libname, librealname) requires at most three argument")

    #LIB_SDK_ROOT下

    #主目录名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #这个设置是强力的，直接改变了发布的lib的名字，编译处的目标名字也改变了。强大。
    #如果用户对TARGET名不满意，用这个参数改变，
    #关系：
    #用户最初设置TARGET 完全用户的思想
    #base manager改为修饰的TARGET。
    #这里，允许用户重新定义TARGET，完全用户的思想
    #自动对名字修饰。
    #不依赖libgroupname
    libname = $$TARGET_NAME
    !isEmpty(2): libname = $$2
    !isEmpty(2) {
        #libname决定target名字，并且直接把TARGET改为_debug/d修饰名。
        TARGET = $$libname
        add_decorate_target()
        #这个位置，需不需要export，存在分歧
        export(TARGET)
    }

    #建议使用默认值
    #这个会影响lib名的后缀，_debug d或者用户定的_xxx
    #如果用户对_debug d等修饰名不满意，那么用这个参数改变。
    #如果用户对自动修饰的名字不满意，那么用这个参数设定经过修饰的名字，自定义的
    #通过这个参数，可以强制不修饰目标名 非标准 这样会影响链接时候的名字，用户链接的时候需要注意链接名
    #依赖libname
    librealname = $$add_decorate_target_name($$libname)
    !isEmpty(3): librealname = $$3
    !isEmpty(3){
        TARGET = $$librealname
        export(TARGET)
    }

    #liblowername依赖librealname
    liblowername = $$lower($${librealname})

    #create platform sdk need this
    #源代码目录
    LIB_SRC_PWD=$${APP_SOURCE_PWD}
    isEmpty(LIB_SRC_PWD):LIB_SRC_PWD=$$PWD

    #编译目标位置
    LIB_DST_DIR=$${APP_BUILD_DESTDIR}
    isEmpty(LIB_DST_DIR):LIB_DST_DIR = $$DESTDIR

    LIB_BUILD_PWD=$${OUT_PWD}
    !isEmpty(LIB_DST_DIR):LIB_BUILD_PWD=$${LIB_BUILD_PWD}/$${LIB_DST_DIR}

    #发布位置
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g
    }

    #message($${TARGET} is builded at $${LIB_BUILD_PWD})
    message($${TARGET} add sdk to $${LIB_SDK_PWD})

    command += $$get_add_sdk_private($${libname}, $${librealname})
    #message($$command)

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
    QMAKE_POST_LINK += $$command

    export(QMAKE_POST_LINK)

    return (1)
}


#发布链接库的SDK到对应平台的Qt库里
#未实现。
#if you want to use QQt with QT += qqt please open this feature
defineTest(add_sdk_to_Qt){
    #isEmpty(1): error("add_sdk_to_Qt(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("add_sdk_to_Qt(libgroupname, libname, librealname) requires at most three argument")

    #LIB_SDK_ROOT下

    #主目录名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #这个设置是强力的，直接改变了发布的lib的名字，编译处的目标名字也改变了。强大。
    #如果用户对TARGET名不满意，用这个参数改变，
    #关系：
    #用户最初设置TARGET 完全用户的思想
    #base manager改为修饰的TARGET。
    #这里，允许用户重新定义TARGET，完全用户的思想
    #自动对名字修饰。
    #不依赖libgroupname
    libname = $$TARGET_NAME
    !isEmpty(2): libname = $$2
    !isEmpty(2) {
        #libname决定target名字，并且直接把TARGET改为_debug/d修饰名。
        TARGET = $$libname
        add_decorate_target()
        #这个位置，需不需要export，存在分歧
        export(TARGET)
    }

    #建议使用默认值
    #这个会影响lib名的后缀，_debug d或者用户定的_xxx
    #如果用户对_debug d等修饰名不满意，那么用这个参数改变。
    #如果用户对自动修饰的名字不满意，那么用这个参数设定经过修饰的名字，自定义的
    #通过这个参数，可以强制不修饰目标名 非标准 这样会影响链接时候的名字，用户链接的时候需要注意链接名
    #依赖libname
    librealname = $$add_decorate_target_name($$libname)
    !isEmpty(3): librealname = $$3
    !isEmpty(3){
        TARGET = $$librealname
        export(TARGET)
    }

    #liblowername依赖librealname
    liblowername = $$lower($${librealname})

    #create platform sdk need this
    #源代码目录
    LIB_SRC_PWD=$${APP_SOURCE_PWD}
    isEmpty(LIB_SRC_PWD):LIB_SRC_PWD=$$PWD

    #编译目标位置
    LIB_DST_DIR=$${APP_BUILD_DESTDIR}
    isEmpty(LIB_DST_DIR):LIB_DST_DIR = $$DESTDIR

    LIB_BUILD_PWD=$${OUT_PWD}
    !isEmpty(LIB_DST_DIR):LIB_BUILD_PWD=$${LIB_BUILD_PWD}/$${LIB_DST_DIR}

    #发布位置
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    message($${TARGET} add sdk to $${LIB_SDK_PWD})

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g
    }

    #message($${TARGET} is builded at $${LIB_BUILD_PWD})

    command += $$get_add_sdk_private($${libname}, $${librealname})
    #message($$command)

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
    QMAKE_POST_LINK += $$command

    export(QMAKE_POST_LINK)

    return (1)
}

#发布用户放置在指定目录里的头文件，*.h*
#LIB组名字  sdkroot下，lib组的名字
#lib库名字  没有修饰的lib库名字 保存头文件的地方
#头文件路径  源代码位置，头文件所在的目录
#保存位置   相对路径，不写则为SDK ROOT下lib库的头文件根目录 （optional）
defineTest(add_sdk_header){
    isEmpty(3):error("add_sdk_header(libgroupname, libname, headerpath, headerdir) need at least three arguments.")

    libgroupname = $$1
    libname = $$2
    headerpath = $$3
    headerdir = $$4

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #不依赖libgroupname
    isEmpty(libname):libname = $$TARGET_NAME

    #headerpath 为空
    isEmpty(headerpath):headerpath = $${PWD}

    #headerdir 为空
    isEmpty(headerdir):headerdir =

    #LIB std dir is not same to app std dir
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    #message(QQt sdk install here:$${LIB_SDK_PWD})

    LIB_INC_DIR = include/$${libname}
    contains(QMAKE_HOST.os, Darwin){
        contains(CONFIG, lib_bundle) {
            LIB_INC_DIR = lib/$${libname}.framework/Headers
        }
    }

    LIB_INC_PWD = $${LIB_SDK_PWD}/$${LIB_INC_DIR}
    !isEmpty(headerdir):LIB_INC_PWD = $${LIB_INC_PWD}/$${headerdir}

    HEADER_PWD = $${headerpath}
    HEADER_FILE = $${headerpath}/*.h*

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_INC_DIR~=s,/,\\,g
        LIB_INC_PWD~=s,/,\\,g

        HEADER_PWD~=s,/,\\,g
        HEADER_FILE~=s,/,\\,g
    }

    message($${TARGET} copy headers $${HEADER_FILE} to sdk header path $${LIB_INC_PWD})

    command =
    command += $$MK_DIR $${LIB_INC_PWD} $$CMD_SEP
    equals(QMAKE_HOST.os, Windows) {
        command += $${COPY_DIR} $${HEADER_PWD}\\*.h* $${LIB_INC_PWD}
    } else {
        command += $$get_copy_dir_and_file($${HEADER_PWD}, "*.h*", $${LIB_INC_PWD})
    }

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK+=$$CMD_SEP
    QMAKE_POST_LINK += $$command
    export(QMAKE_POST_LINK)

    return(1)
}

#发布用户放置在指定目录里的头文件，所有后缀
#LIB组名字  sdkroot下，lib组的名字
#lib库名字  没有修饰的lib库名字 保存头文件的地方
#头文件路径  源代码位置，头文件所在的目录
#保存位置   相对路径，不写则为SDK ROOT下lib库的头文件根目录 （optional）
defineTest(add_sdk_header_all){
    isEmpty(3):error("add_sdk_header_all(libgroupname, libname, headerpath, headerdir) need at least three arguments.")

    libgroupname = $$1
    libname = $$2
    headerpath = $$3
    headerdir = $$4

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #不依赖libgroupname
    isEmpty(libname):libname = $$TARGET_NAME

    #headerpath 为空
    isEmpty(headerpath):headerpath = $${PWD}

    #headerdir 为空
    isEmpty(headerdir):headerdir =

    #LIB std dir is not same to app std dir
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    #message(QQt sdk install here:$${LIB_SDK_PWD})

    LIB_INC_DIR = include/$${libname}
    contains(QMAKE_HOST.os, Darwin){
        contains(CONFIG, lib_bundle) {
            LIB_INC_DIR = lib/$${libname}.framework/Headers
        }
    }

    LIB_INC_PWD = $${LIB_SDK_PWD}/$${LIB_INC_DIR}
    !isEmpty(headerdir):LIB_INC_PWD = $${LIB_INC_PWD}/$${headerdir}

    HEADER_PWD = $${headerpath}
    HEADER_FILE = $${headerpath}/*

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_INC_DIR~=s,/,\\,g
        LIB_INC_PWD~=s,/,\\,g

        HEADER_PWD~=s,/,\\,g
        HEADER_FILE~=s,/,\\,g
    }

    message($${TARGET} copy headers $${HEADER_FILE} to sdk header path $${LIB_INC_PWD})

    command =
    command += $$MK_DIR $${LIB_INC_PWD} $$CMD_SEP
    equals(QMAKE_HOST.os, Windows) {
        command += $${COPY_DIR} $${HEADER_PWD}\\* $${LIB_INC_PWD}
    } else {
        command += $$get_copy_dir_and_file($${HEADER_PWD}, "*", $${LIB_INC_PWD})
    }

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK+=$$CMD_SEP
    QMAKE_POST_LINK += $$command
    export(QMAKE_POST_LINK)

    return(1)
}

#发布用户放置在指定目录里的头文件，可选后缀
#LIB组名字  sdkroot下，lib组的名字
#lib库名字  没有修饰的lib库名字 保存头文件的地方
#头文件路径  源代码位置，头文件所在的目录
#头文件后缀  源代码位置，头文件的后缀，通配，默认为*.h*
#保存位置   相对路径，不写则为SDK ROOT下lib库的头文件根目录 （optional）
defineTest(add_sdk_header_ex){
    isEmpty(3):error("add_sdk_header_ex(libgroupname, libname, headerpath, headerpostfix, headerdir) need at least three arguments.")

    libgroupname = $$1
    libname = $$2
    headerpath = $$3
    headerpostfix = $$4
    headerdir = $$5

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #不依赖libgroupname
    isEmpty(libname):libname = $$TARGET_NAME

    #headerpath 为空
    isEmpty(headerpath):headerpath = $${PWD}

    #headerpostfix 为空
    isEmpty(headerpostfix):headerpostfix = *.h*

    #headerdir 为空
    isEmpty(headerdir):headerdir =

    #LIB std dir is not same to app std dir
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    #message(QQt sdk install here:$${LIB_SDK_PWD})

    LIB_INC_DIR = include/$${libname}
    contains(QMAKE_HOST.os, Darwin){
        contains(CONFIG, lib_bundle) {
            LIB_INC_DIR = lib/$${libname}.framework/Headers
        }
    }

    LIB_INC_PWD = $${LIB_SDK_PWD}/$${LIB_INC_DIR}
    !isEmpty(headerdir):LIB_INC_PWD = $${LIB_INC_PWD}/$${headerdir}

    HEADER_PWD = $${headerpath}
    HEADER_FILE = $${headerpath}/$${headerpostfix}

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_INC_DIR~=s,/,\\,g
        LIB_INC_PWD~=s,/,\\,g

        HEADER_PWD~=s,/,\\,g
        HEADER_FILE~=s,/,\\,g
    }

    message($${TARGET} copy headers $${HEADER_FILE} to sdk header path $${LIB_INC_PWD})

    command =
    command += $$MK_DIR $${LIB_INC_PWD} $$CMD_SEP
    equals(QMAKE_HOST.os, Windows) {
        command += $${COPY_DIR} $${HEADER_PWD}\\$${headerpostfix} $${LIB_INC_PWD}
    } else {
        command += $$get_copy_dir_and_file($${HEADER_PWD}, "$${headerpostfix}", $${LIB_INC_PWD})
    }

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK+=$$CMD_SEP
    QMAKE_POST_LINK += $$command
    export(QMAKE_POST_LINK)

    return(1)
}

#发布没有后缀名的头文件
#帮助用户把头文件后缀去掉，按照指定的名字，发布到指定的位置。
#主目录名  sdkroot下，lib组
#库名字   没有修饰的库名字 保存头文件的地方
#类名     头文件的名称
#保存位置  相对路径 不写则为头文件根目录。
#头文件   不设置 为空 则为类名小写。头文件里包含的.h头
defineTest(add_sdk_header_no_postfix){
    isEmpty(3):error("add_sdk_header_no_postfix(libgroupname, libname, classname, headerdir, headername) need at least three arguments.")

    libgroupname = $$1
    libname = $$2
    classname = $$3
    headerdir = $$4
    headername = $$5

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #不依赖libgroupname
    isEmpty(libname):libname = $$TARGET_NAME

    #依赖classname
    isEmpty(headername):headername = $$lower($${classname}).h

    #LIB std dir is not same to app std dir
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    #message(QQt sdk install here:$${LIB_SDK_PWD})

    LIB_INC_DIR = include/$${libname}
    contains(QMAKE_HOST.os, Darwin){
        contains(CONFIG, lib_bundle) {
            LIB_INC_DIR = lib/$${libname}.framework/Headers
        }
    }

    !isEmpty(headerdir):headerdir=$${headerdir}/
    HEADER_FILE = $${headerdir}$${classname}

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        APP_BUILD_ROOT~=s,/,\\,g
        LIB_SDK_ROOT~=s,/,\\,g
        APP_DEPLOY_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_DST_DIR~=s,/,\\,g
        LIB_BUILD_PWD~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_INC_DIR~=s,/,\\,g
        HEADER_FILE~=s,/,\\,g
    }

    message($${TARGET} add header $${headername} to $${HEADER_FILE})

    command =
    command += $$CD $${LIB_SDK_PWD} $$CMD_SEP
    command += $$CD $${LIB_INC_DIR} $$CMD_SEP

    contains(QMAKE_HOST.os, Windows){
        command += $${ADD_SDK_PRI_PWD}/win_write_header.bat $${headername} $${HEADER_FILE}
    } else {
        command += chmod +x $${ADD_SDK_PRI_PWD}/linux_write_header.sh $$CMD_SEP
        command += $${ADD_SDK_PRI_PWD}/linux_write_header.sh $${headername} $${HEADER_FILE}
    }

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK+=$$CMD_SEP
    QMAKE_POST_LINK += $$command
    export(QMAKE_POST_LINK)

    return(1)
}

#清理SDK仓的里的确定的SDK
#未实现。
defineTest(clean_sdk){
    #isEmpty(1): error("clean_sdk(libgroupname, libname, librealname) requires at least one argument")
    !isEmpty(4): error("clean_sdk(libgroupname, libname, librealname) requires at most three argument")

    #LIB_SDK_ROOT下

    #主目录名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了LIB_SDK_TARGET_NAME，那么服从LIB_SDK_TARGET_NAME。
    !equals(LIB_SDK_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_SDK_TARGET_NAME}

    #不依赖libgroupname
    libname = $$TARGET_NAME
    !isEmpty(2): libname = $$2

    #依赖libname
    librealname = $$add_decorate_target_name($$libname)
    !isEmpty(3): librealname = $$3

    #liblowername依赖librealname
    liblowername = $$lower($${librealname})

    #LIB std dir is not same to app std dir
    LIB_STD_DIR = $${libgroupname}/$${QSYS_STD_DIR}

    #sdk path
    LIB_SDK_PWD = $${LIB_SDK_ROOT}/$${LIB_STD_DIR}
    #message(QQt sdk install here:$${LIB_SDK_PWD})

    LIB_SDK_ALL1 = $${LIB_SDK_PWD}/lib/*$${libname}.*
    LIB_SDK_ALL2 = $${LIB_SDK_PWD}/lib/*$${librealname}.*
    LIB_SDK_ALL3 = $${LIB_SDK_PWD}/bin/*$${libname}.*
    LIB_SDK_ALL4 = $${LIB_SDK_PWD}/bin/*$${librealname}.*
    LIB_SDK_ALL5 = $${LIB_SDK_PWD}/include/$${libname}/*

    #这里不仅仅目标为windows的时候，才会转换，
    #开发Host为Windows的时候，都要转换。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64) {
    equals(QMAKE_HOST.os, Windows) {
        LIB_SDK_ROOT~=s,/,\\,g

        QSYS_STD_DIR~=s,/,\\,g
        LIB_STD_DIR~=s,/,\\,g
        LIB_SDK_PWD~=s,/,\\,g

        LIB_SDK_ALL1~=s,/,\\,g
        LIB_SDK_ALL2~=s,/,\\,g
        LIB_SDK_ALL3~=s,/,\\,g
        LIB_SDK_ALL4~=s,/,\\,g
        LIB_SDK_ALL5~=s,/,\\,g
    }

    command += $$RM_DIR $${LIB_SDK_ALL1} $$CMD_SEP
    command += $$RM_DIR $${LIB_SDK_ALL2} $$CMD_SEP
    command += $$RM_DIR $${LIB_SDK_ALL3} $$CMD_SEP
    command += $$RM_DIR $${LIB_SDK_ALL4} $$CMD_SEP
    command += $$RM_DIR $${LIB_SDK_ALL5}
    #message($$command)

    !isEmpty(QMAKE_PRE_LINK):QMAKE_PRE_LINK += $$CMD_SEP
    QMAKE_PRE_LINK += $$command

    export(QMAKE_PRE_LINK)

    return (1)
}

# = add_sdk
defineTest(add_export){
    libgroupname = $$1
    libname = $$2
    librealname = $$3
    ret =
    add_sdk($$libgroupname, $$libname, $$librealname):ret =1
    else : ret = 0
    return ($$ret)
}

#内部默认 $$PWD
APP_SOURCE_PWD =
#内部默认 $$DESTDIR
APP_BUILD_DESTDIR =
#内部默认 $$TARGET_NAME $$libname
APP_PROJECT_NAME =
#这个值为什么初始化是空的呢？
#QMAKE_PROJECT_NAME = $$TARGET

#这个目录用于读取sdk头文件进行发布
#这个目录可选设置
#如果调用这个函数的文件所在不是在源代码目录下，比如$${PWD}/../src，可以通过这里修正
defineTest(add_header_dir){
    APP_SOURCE_PWD = $$1
    export(APP_SOURCE_PWD)
    return (1)
}

defineTest(add_source_dir){
    APP_SOURCE_PWD = $$1
    export(APP_SOURCE_PWD)
    return (1)
}

#这个目录用于读取sdk库文件进行发布
#废弃函数，内部使用了OUT_PWD
#这个目录可选设置
#如果用户更改了编译目录DEST_DIR_TARGET，比如src/$$DEST_DIR，可以通过这里改变，当然这种设置不科学，内部依赖DEST_DIR，为什么还要用DESTDIR_TARGET。
defineTest(add_build_dir){
    APP_BUILD_DESTDIR = $$1
    export(APP_BUILD_DESTDIR)
    return (1)
}

