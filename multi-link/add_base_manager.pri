#---------------------------------------------------------------------------------
#add_base_manager.pri
#应用程序和Library的基础管理器，统一使用这个管理器。
#base header包揽所有的app和lib的通用设置
#base manager包揽所有app和lib启动的函数
#V2.0
#和同目录下pri组一同拷贝使用，不拷贝可以使用。建议不拷贝使用，可以跟进技术更新。
#设计难度：控制难度，丰富接口。
#在Multi-PC、Multi-plat开发的时候，能够体现优势。
#---------------------------------------------------------------------------------
#简介
#在这个管理器里，App和Lib工程其实是区分开的。
#尤其动态编译 配置开关、宏定义 是在这里处理的，但是静态编译 配置开关在这里、宏定义在base_header里。这里需要加强理解。
#这是重点。

################################################################################
#初始化
################################################################################
ADD_BASE_MANAGER_PRI_PWD = $${PWD}

################################################################################
#包含这个pri依赖的pri
#设置目标平台 QSYS
################################################################################
include ($${PWD}/add_platform.pri)
include ($${PWD}/add_function.pri)

################################################################################
#多链接技术入口
#配置重要的三个路径 APP_BUILD_ROOT APP_DEPLOY_ROOT LIB_SDK_ROOT
################################################################################
include($${PWD}/add_multi_link_technology.pri)

################################################################################
#这里的pri提供multi link的全部函数
#增加发布
#增加发布配置
#增加链接库
#增加链接库头文件
#增加SDK (lib用)
#增加版本信息
################################################################################
#app发布所需要的函数
include ($${PWD}/add_deploy.pri)

#app发布library所需要的函数
include ($${PWD}/add_deploy_library.pri)

#app发布配置项需要的函数
include ($${PWD}/add_deploy_config.pri)

#链接lib所需要的函数 包含lib头文件所需要的函数 设置lib宏所需要的函数
include ($${PWD}/add_library.pri)

#lib发布sdk所需要的函数
#注释：提供修改Target名字的函数
include ($${PWD}/add_sdk.pri)

#program version
include ($${PWD}/add_version.pri)

#program language
include ($${PWD}/add_language.pri)

####################################################################################
#base manager 都做了以下这些事情
####################################################################################
#工程层级介绍：
#add_library在基本的链接层
#add_sdk 出现在library层
#add_dependent_library add_dependent_manager 出现在app层。在这Multi-link里，用dependent函数，统筹实现。
#工程管理层级上是递进关系。在二进制上他们是互相兼容的，平行关系。

#################################################################
#定义外部函数
#################################################################

#################################################################
#这是一个强大的函数
#调用这一个函数就可以调用add_library_XXX.pri里实现的函数
#################################################################
#这个函数，如果为app工程，则包含deploy过程，如果是lib工程则不包括。
#函数不可缺席，否则会影响整个工程管理的正常运行。
defineTest(add_dependent_manager){
    libgroupname = $$1
    libname = $$2
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname

    !equals(TARGET_NAME, $${libname}){
        exists($${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_$${libgroupname}.pri) {
            include ($${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_$${libgroupname}.pri)
            #添加头文件 参数为空，为SDK里的路径。
            add_include_$${libname}()
            #添加宏定义
            add_defines_$${libname}()
            #链接Library
            add_library_$${libname}()
            contains(TEMPLATE, app) {
                #发布Library
                add_deploy_library_$${libname}()
            }
        } else {
            message(please check is $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_$${libgroupname}.pri existed?)
            return (0)
        }
    } else {
        message(please check your target name $$TARGET_NAME and lib name $$libname)
        return (0)
    }
    return (1)
}

#从自定义路径加载add_library_<libname>.pri
#第二个参数为空，则从调用处添加。
defineTest(add_custom_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname
    isEmpty(pripath):pripath = $${PWD}

    !equals(TARGET_NAME, $${libname}){
        exists($${pripath}/add_library_$${libgroupname}.pri) {
            include ($${pripath}/add_library_$${libgroupname}.pri)
            #添加头文件 参数为空，为SDK里的路径。
            add_include_$${libname}()
            #添加宏定义
            add_defines_$${libname}()
            #链接Library
            add_library_$${libname}()
            contains(TEMPLATE, app) {
                #发布Library
                add_deploy_library_$${libname}()
            }
        } else {
            message(please check is $${pripath}/add_library_$${libgroupname}.pri existed?)
            return (0)
        }
    } else {
        message(please check your target name $$TARGET_NAME and lib name $$libname)
        return (0)
    }
    return (1)
}

#开启app工程
defineTest(add_app_project) {
    #add base manager对App的处理很少，App通过函数基本上能解决所有的事情
    #macOS下必须开开bundle
    contains(QSYS_PRIVATE, macOS){
        CONFIG += app_bundle
    }

    #直到现在，还没有碰到需要静态链接的场合。
    #如果需要，用户可以自行设定。
    export(CONFIG)
    export(DEFINES)

    return (1)
}

#开启lib工程
defineTest(add_lib_project) {
    ##base manager 对lib的处理很重要
    ##区分了在不同目标下Qt library的不同形态，其实就是要求lib工程和Qt library保持一样的状态。
    ##尤其在windows平台下，还提供了LIB_STATIC_LIBRARY 和 LIB_LIBRARY两个宏的支持
    ##帮助用户区分lib的状态。
    ##注意：在app下，永远没有dll或者static字样，只有lib有

    ##win platform: some target, special lib lib_bundle staticlib
    ##only deal dynamic is ok, static all in headers dealing.
    ##define macro before header.
    #专门为lib工程设置
    contains(QSYS_PRIVATE, Win32|Windows|Win64) {
        #Qt is static by mingw32 building
        mingw {
            #on my computer , Qt library are all static library?
            #create static lib (important, only occured at builder pro)
            #CONFIG += staticlib
            #在add_base_header里设置
            #DEFINES += LIB_STATIC_LIBRARY
            #在我电脑上编译别的lib mingw下是dll格式的。
            CONFIG += dll
            DEFINES += LIB_LIBRARY
            #mingw编译为静态有原因：动态库可以编译成功，但是无法链接成功。
            #终于查清楚原因了，mingw编译app工程，某个原因，不改动调用源代码，工程链接就会提示失败，即便链接上了。可能mingw的bug，也可能是操作系统的bug。
            message(Build $${TARGET} LIB_LIBRARY is defined. build)
        } else {
            #create dynamic lib (important, only occured at builder pro)
            CONFIG += dll
            #no other one deal this, define it here, right here.
            DEFINES += LIB_LIBRARY
            message(Build $${TARGET} LIB_LIBRARY is defined. build)
        }
    #*nux platform: no macro
    } else {
        contains(QSYS_PRIVATE, macOS) {
            CONFIG += dll
            #macOS下必须开开bundle
            CONFIG += lib_bundle
        } else:contains(QSYS_PRIVATE, iOS|iOSSimulator) {
            CONFIG += static
        } else {
            ##default build dll
            CONFIG += dll
            #*nix no need this macro
            #DEFINES += LIB_LIBRARY
        }
    }

    #CONFIG += build_pass
    build_pass:CONFIG(debug, debug|release) {
        #troublesome
        #win32: TARGET = $$join(TARGET,,,d)
    }

    #lib 必须创建prl
    #create sdk need
    CONFIG += create_prl

    #debug版本和release版本的所有的不同。
    #Lib的TARGET，在两个版本上有区别，通过TARGET = add_decorate_target($$TARGET)可以解决。
    #App的TARGET，在两个版本上，名字没有区别。

    export(CONFIG)
    export(DEFINES)

    return (1)
}

#获取target的确切的名字
#区分debug和release用的。
#输入，target_name 为空，则默认为TARGET
#输出，target_name?x
#这个变量用来保存原生的target name
TARGET_NAME = $$TARGET
TARGET_DECORATE_NAME = $$TARGET_NAME
#获取sdk name
#修饰TARGET _d _debug
#保证修饰
defineReplace(add_decorate_target_name){
    #isEmpty(1):error(add_decorate_target_name(target_name) need one argument)

    target_name = $$TARGET_NAME
    !isEmpty(1):target_name = $$1

    ret = $${target_name}
    contains(BUILD, Debug) {
        mac:ret = $${ret}_debug
        win32:ret = $${ret}d
    }

    return ($$ret)
}

#保证还原
defineReplace(add_target_name){
    return ($$TARGET_NAME)
}

#修饰
defineTest(add_decorate_target){
    #isEmpty(1):error(add_decorate_target(target_name) need one argument)
    target_name = $$TARGET_NAME
    !isEmpty(1):target_name = $$1

    ret = $$add_decorate_target_name($${target_name})
    TARGET_DECORATE_NAME = $$ret
    export(TARGET_DECORATE_NAME)
    TARGET = $$ret
    export(TARGET)
    return (1)
}

#还原
defineTest(add_target){
    TARGET_DECORATE_NAME = $$TARGET_NAME
    export(TARGET_DECORATE_NAME)
    TARGET = $$TARGET_NAME
    export(TARGET)
    return (1)
}


#设置模板名字
TEMPLATE_PRIVATE = $$TEMPLATE
defineTest(add_template){
    #isEmpty(1):error(add_template(template_name) need one argument)

    template_name = $$1
    isEmpty(1):template_name = $$TEMPLATE

    TEMPLATE_PRIVATE = $$template_name
    export(TEMPLATE_PRIVATE)

    return(1)
}

#添加源文件
defineTest(add_sources){
    isEmpty(1):error(add_sources(source_name) need one argument)

    source_name = $$1

    SOURCES += $$source_name
    export(SOURCES)

    return(1)
}

#添加头文件
defineTest(add_headers) {
    headername = $$1
    isEmpty(1)|!isEmpty(2): error("add_headers(headername) requires one argument")

    command = $${headername}
    #message ($$command)

    HEADERS += $${command}
    export(HEADERS)

    return (1)
}

defineTest(add_defines) {
    defname = $$1
    isEmpty(1)|!isEmpty(2): error("add_defines(defname) requires one argument")

    command = $${defname}
    #message ($$command)

    DEFINES += $${command}
    export(DEFINES)

    return (1)
}

defineTest(add_post_link){
    command = $$1
    isEmpty(command):return(0)

    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK += $$CMD_SEP
    QMAKE_POST_LINK += $$command
    export(QMAKE_POST_LINK)

    return (1)
}

defineTest(add_pre_link){
    command = $$1
    isEmpty(command):return(0)

    !isEmpty(QMAKE_PRE_LINK):QMAKE_PRE_LINK += $$CMD_SEP
    QMAKE_PRE_LINK += $$command
    export(QMAKE_PRE_LINK)

    return (1)
}

defineTest(add_include_path) {
    header_path = $$1
    isEmpty(header_path):header_path=$$PWD

    INCLUDEPATH += $$header_path
    export(INCLUDEPATH)

    return (1)
}

#内部默认 $$PWD
APP_SOURCE_PWD =
#内部默认 $$DESTDIR
APP_BUILD_DESTDIR =
#内部默认 $$TARGET_NAME $$libname
APP_PROJECT_NAME =
#这个值为什么初始化是空的呢？
QMAKE_PROJECT_NAME = $$TARGET

#这个目录用于读取sdk头文件进行发布
#这个目录可选设置
#如果调用这个函数的文件所在不是在源代码目录下，比如$${PWD}/../src，可以通过这里修正
defineTest(add_source_dir){
    APP_SOURCE_PWD = $$1
    export(APP_SOURCE_PWD)
    return (1)
}

#这个目录用于读取sdk库文件进行发布
#这个目录可选设置
#如果用户更改了编译目录DEST_DIR_TARGET，比如src/$$DEST_DIR，可以通过这里改变，当然这种设置不科学，内部依赖DEST_DIR，为什么还要用DESTDIR_TARGET。
defineTest(add_build_dir){
    APP_BUILD_DESTDIR = $$1
    export(APP_BUILD_DESTDIR)
    return (1)
}

#如果工程名字和目标名字不一样，可以修正。
#比如：TARGET = ABC 工程名 = EFG[.pro] 就要调用这个函数设置工程名为ABC，Creator工程树上的工程名字就会改变。
#这是一个装饰函数。
defineTest(add_project_name){
    APP_PROJECT_NAME = $$1
    export(APP_PROJECT_NAME)
    QMAKE_PROJECT_NAME = $$1
    export(QMAKE_PROJECT_NAME)
    return (1)
}

#把路径转换为平台上接受的路径。
defineReplace(add_host_path){
    path = $$1
    equals(QMAKE_HOST.os, Windows) {
        path~=s,/,\\,g
    }
    return ($$path)
}

#获取开发平台的名称
defineReplace(add_host_name){
    #Windows Darwin Linux
    return ($${QMAKE_HOST.os})
}

#获取目标平台的名称
defineReplace(add_xplatform_name){
    #Windows Win32 Win64 macOS iOS iOSSimulator Android AndroidX86 Linux Linux64 Arm32 Mips32 Embedded
    return ($${QSYS_PRIVATE})
}

#未实现。
defineTest(clean_target) {
    LIB_DST_DIR=$${APP_BUILD_DESTDIR}
    isEmpty(LIB_DST_DIR):LIB_DST_DIR = $$DESTDIR
    LIB_BUILD_PWD=$${OUT_PWD}
    !isEmpty(LIB_DST_DIR):LIB_BUILD_PWD=$${LIB_BUILD_PWD}/$${LIB_DST_DIR}
    LIB_BUILD_TARGETS = $${LIB_BUILD_PWD}/*$${TARGET}.*
    LIB_BUILD_TARGETS = $$add_host_path($$LIB_BUILD_TARGETS)
    add_pre_link($$RM $$LIB_BUILD_TARGETS)
    return (1)
}

#################################################################
##definition and configration
##need QSYS
#################################################################
#这个编译，build pane比较简洁
#CONFIG += silent
#multi-link v2.0对这个功能有良好的支持。
#CONFIG += debug_and_release
#编译全部
#CONFIG += build_all

#修饰TARGET LIB必要 APP可选 only once
#此处提醒用户：你肯定不愿意手动调用。

#格式
#debug版本，_debug d，无论app lib，还是链接的lib，发布的lib，和发布的sdk都是这样的。
#release版本，没有后缀。
#用户在链接库的时候，需要分类处理，debug版本和release版本，准备哪种版本，才能链接哪种版本。
#

add_decorate_target($${TARGET_NAME})

contains(TEMPLATE, app) {
    #启动app工程 APP必要
    add_app_project()
} else: contains(TEMPLATE, lib) {
    #启动lib工程 LIB必要
    add_lib_project()
}

#################################################################
#公共的基础header.pri，这个的作用在于不需要区分app和lib的设置都在这里面。
#包含基本的编译设置 qqt_header.pri里的设置更详细
#这个header在所有的函数包含完以后，添加，因为这个header其实也依赖Multi-link技术。
#################################################################
include ($${PWD}/add_base_header.pri)


#message($$TARGET config $$CONFIG)
#message($$TARGET define $$DEFINES)
#message($$TARGET pre link $$QMAKE_PRE_LINK)
#message($$TARGET post link $$QMAKE_POST_LINK)
