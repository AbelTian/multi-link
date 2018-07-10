#---------------------------------------------------------------------------------
#add_base_manager.pri
#2018年6月30日 22点04分
#工程很常用的函数，一般在manager里会用。

#---------------------------------------------------------------------------------

#工程层级介绍：
#add_library在基本的链接层
#add_sdk 出现在library层
#add_dependent_library add_dependent_manager 出现在app层。在这Multi-link里，用dependent函数，统筹实现。
#工程管理层级上是递进关系。在二进制上他们是互相兼容的，平行关系。

#################################################################
#定义外部函数
#################################################################
#add_dependent_manager()
#add_custom_dependent_manager()
#add_create_dependent_manager()
#add_app_project()
#add_lib_project()
#add_decorate_target_name()
#add_target_name()
#add_decorate_target()
#add_target()
#add_template()
#add_sources()
#add_headers()
#add_defines()
#add_post_link()
#add_pre_link()
#add_include_path()
#add_source_dir()
#add_build_dir()
#add_project_name()
#add_host_path()
#add_host_name()
#add_xplatform_name()
#clean_target()
#get_app_deploy_path()


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

defineTest(add_create_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    !exists($${pripath}/add_library_$${libgroupname}.pri) {
        srcFile = $${pripath}/add_library_Template.pri
        dstFile = $${pripath}/add_library_$${libgroupname}.pri
        contains(QMAKE_HOST.os, Windows) {
            srcFile = $$add_host_path($$srcFile)
            dstFile = $$add_host_path($$dstFile)
        }

        system_errcode($$COPY $${srcFile} $${dstFile}){
            message(create $$dstFile success.)
        }
    }

    add_custom_dependent_manager($$libgroupname, $$libname, $$pripath)
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
    contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
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

############################################################
#Multi-link内部有固定的链接逻辑，但是可以从这里强制改变。
#Multi-link内部默认只有在ios里，才会静态编译和链接library。
############################################################
#强制更换为动态库 （Only lib project）
defineTest(add_dynamic_library_project) {
    #删除静态设置
    CONFIG -= static staticlib
    DEFINES -= LIB_STATIC_LIBRARY
    #添加动态设置
    CONFIG += dll
    contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        DEFINES += LIB_LIBRARY
        message(Build $${TARGET} LIB_LIBRARY is defined. build)
    }
}

#强制更换为静态库 （Only lib project）
defineTest(add_static_library_project) {
    #删除动态设置
    CONFIG -= dll
    DEFINES -= LIB_LIBRARY
    #添加静态设置
    CONFIG += static staticlib
    DEFINES += LIB_STATIC_LIBRARY
    message(Build $${TARGET} LIB_STATIC_LIBRARY is defined. build and link)
}

#app想要静态链接library，那么可以从这里强制静态链接。
defineTest(add_static_link_library) {
    #添加静态设置
    DEFINES += LIB_STATIC_LIBRARY
    message(Build $${TARGET} LIB_STATIC_LIBRARY is defined. build and link)
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
        #linux debug and release is same to each other.
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

#获取App的发布路径
defineReplace(get_app_deploy_path) {
    appgroupname = $$TARGET_NAME
    !isEmpty(1):appgroupname=$$1

    #发布位置
    APP_STD_DIR = $${appgroupname}/$${QAPP_STD_DIR}

    #set app deploy pwd
    #APP_DEPLOY_PWD is here.
    APP_DEPLOY_PWD = $${APP_DEPLOY_ROOT}/$${APP_STD_DIR}

    APP_DEPLOY_PWD = $$add_host_path($$APP_DEPLOY_PWD)

    return ($$APP_DEPLOY_PWD)
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
    #MSVC MSVC32 MSVC64 Windows Win32 Win64 macOS iOS iOSSimulator Android AndroidX86 Linux Linux64 Arm32 Armhf32 Mips32 Embedded
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

#create file
defineTest(add_file){
    file_name = $$1
    exists($${file_name}):return(0)
    empty_file($${file_name})
    return(1)
}

