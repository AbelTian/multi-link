#---------------------------------------------------------------------------------
#add_project.pri
#2018年6月30日 22点04分
#工程很常用的函数。
#
#please don't modify this pri
#---------------------------------------------------------------------------------

#工程层级介绍：
#add_library在基本的链接层
#add_sdk 出现在library层
#add_dependent_manager 出现在app层。在这Multi-link里，用dependent函数，统筹实现。
#工程管理层级上是递进关系。在二进制上他们是互相兼容的，平行关系。

#################################################################
#定义外部函数
#################################################################
#add_dependent_manager()
#add_create_dependent_manager()
#add_custom_dependent_manager()
#add_custom_dependent_manager2()

#v2.4
#add_static_dependent_manager()
#add_create_static_dependent_manager()
#add_custom_static_dependent_manager()
#add_custom_static_dependent_manager2()

#兼容 v2.3 的链接环
#add_static_dependent_manager_v23()
#add_create_static_dependent_manager_v23()
#add_custom_static_dependent_manager_v23()
#add_custom_static_dependent_manager2_v23()

#v2.4 library 的编译控制
#add_dynamic_library_project()
#add_static_library_project()
#add_library_export_macro()

#内部默认编译过程
#add_decorate_target()
#add_app_project()
#add_lib_project()
#add_default_library_project() #dynamic

#add_decorate_target_name()
#add_target_name()
#add_target()
#add_template()
#add_sources()
#add_headers()
#add_defines()
#add_post_link()
#add_pre_link()
#add_headers_path()
#add_include_path() = (add_headers_path)
#add_project_name()
#add_host_path()
#add_host_name()
#add_xplatform_name()
#add_file()

#get_app_deploy_path()
#clean_target()

#################################################################
#这是一个强大的函数
#调用这一个函数就可以调用add_library_XXX.pri里实现的函数
#################################################################
#这个函数，如果为app工程，则包含deploy过程，如果是lib工程则不包括。
#相应pri内函数不可缺席，否则会影响整个工程管理的正常运行。
#仅仅动态链接依赖库。
#lib工程，动态链接正常，静态链接导致全静态，存在问题。
#app工程，动态链接正常，静态链接也会拷贝，存在问题。
#从默认路径加载add_library_<libgroupname>.pri
#参数1 libgroupname
#参数2 libname
#参数3 加载路径 为空则默认在multi-link/app-lib 可以自定义，比如$$PWD $${LIB_SDK_ROOT}/app-lib
defineTest(add_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    #Multi-link v2.4 提供的CONFIG
    DY0CONFIG =
    DYCONFIG =
    DY0CONFIG += link_static_$${libgroupname} build_link_$${libgroupname}
    DYCONFIG += link_$${libgroupname}
    !equals(libname, $${libgroupname}){
        DY0CONFIG += link_static_$${libname} build_link_$${libname}
        DYCONFIG += link_$${libname}
    }
    CONFIG -= $${DY0CONFIG}
    CONFIG += $${DYCONFIG}

    #链接库，去除静态的宏
    DY0DEFINE =
    LIBGROUPNAME = $$upper($${libgroupname})
    DY0DEFINE += $${LIBGROUPNAME}_STATIC_LIBRARY
    !equals(libname, $${libgroupname}){
        LIBNAME = $$upper($${libname})
        DY0DEFINE += $${LIBNAME}_STATIC_LIBRARY
    }
    DEFINES -= $${DY0DEFINE}

    !equals(TARGET_NAME, $${libname}){
        exists($${pripath}/add_library_$${libgroupname}.pri) {
            include ($${pripath}/add_library_$${libgroupname}.pri)
            #这个位置调用肯定是SDK里的路径，但是qmake v3.1有个bug，e-linux目标，这里$${libname}有一定的概率被解析成参数1，函数名倒是还是正确的，多了个参数。
            #fix:由于library的header有是否为bundle的区别，这里无法照顾区别，不方便传参，所以，在add_library_$${libgroupname}.pri里，删除这个函数的参数，这个函数以后无参了。
            #添加头文件 参数为空，为SDK里的路径。
            add_include_$${libname}()
            #添加宏定义
            add_defines_$${libname}()
            #链接Library
            add_library_$${libname}()
            #app工程发布依赖库，lib project全都不发布依赖库。
            contains(TEMPLATE, app):add_deploy_library_$${libname}()
        } else {
            message(please check is $${pripath}/add_library_$${libgroupname}.pri existed?)
            return (0)
        }
    } else {
        message(please check your target name $$TARGET_NAME and lib name $$libname)
        return (0)
    }

    export(CONFIG)
    export(DEFINES)

    return (1)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
defineTest(add_create_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    equals(libname, Template):error("User cannot create add_library_Template.pri anywhere .")

    !exists($${pripath}/add_library_$${libgroupname}.pri) {
        srcFile = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_Template.pri
        dstFile = $${pripath}/add_library_$${libgroupname}.pri
        contains(QMAKE_HOST.os, Windows) {
            srcFile = $$add_host_path($$srcFile)
            dstFile = $$add_host_path($$dstFile)
        }

        system_errcode($$COPY $${srcFile} $${dstFile}){
            message(create $$dstFile success.)
        }

        #添加自动替换的功能
    }

    add_dependent_manager($$libgroupname, $$libname, $$pripath)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#参数3 为空则为当前路径 $$PWD 调用处
defineTest(add_custom_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${PWD}
    add_create_dependent_manager($$libgroupname, $$libname, $$pripath)
    return(1)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#默认路径是SDK ROOT下app-lib
defineTest(add_custom_dependent_manager2){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname
    isEmpty(pripath):pripath = $${LIB_SDK_ROOT}/app-lib
    add_create_dependent_manager($$libgroupname, $$libname, $$pripath)
}

#以上函数，存在以下问题。
#应用链接动态库，没问题。
#应用链接静态库，有问题。
    #发布过程无法判断是否为静态链接，所以上述函数不能用。过去提出使用add_link_dependent_mananger()来解决，不发布了。
    #无法针对确定的链接库提供确定的静态宏。过去提出使用add_static_link_library()来解决，全部库都静态连接了，不行。

#动态库链接动态库，没问题。
#动态库链接静态库，有问题。
    #链接静态库需要给链接库添加准确对应的STATIC宏，使用LIB_STATIC_LIBRARY导致全部库静态链接了。
    #LIB_STATIC_LIBRARY把当前库变成了静态库。

#静态库链接动态库，有问题。
    #LIB_STATIC_LIBRARY把链接库变成静态链接方式。
#静态库链接静态库，有问题。
    #链接静态库需要给链接库添加准确对应的STATIC宏，使用LIB_STATIC_LIBRARY导致全部库静态链接了。

#所以，Multi-link 2.2对静态库支持还不好，现在更新到Multi-link 2.3，修复这个问题。
    #约束
    #1. 只要链接库使用自定义的动态工程宏、静态工程宏就没有问题。
        #比如，QQT_LIBRARY，不要使用LIB_LIBRARY。
        #比如，QQT_STATIC_LIBRARY，不要使用LIB_STATIC_LIBRARY。
    #2. 链接库的自定义工程状态宏，必须被Multi-link提供的这两个工程状态宏决定。
    #3. 静态库链接动态库的问题也被解决了，在链接环模板里解决的。

#这个函数解决全部静态链接库
#lib工程，不发布库，要求链接库静态宏，不会改变当前工程的属性。
#app工程，不发布库，要求链接库静态宏，不会改变当前工程的属性。
#从默认路径加载add_library_<libgroupname>.pri
#参数1 libgroupname
#参数2 libname
#参数3 加载路径 为空则默认在multi-link/app-lib 可以自定义，比如$$PWD $${LIB_SDK_ROOT}/app-lib
defineTest(add_static_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    #Multi-link v2.4 提供的CONFIG
    ST0CONFIG =
    STCONFIG =
    ST0CONFIG += link_$${libgroupname}
    STCONFIG += link_static_$${libgroupname} build_link_$${libgroupname}
    !equals(libname, $${libgroupname}){
        ST0CONFIG += link_$${libname}
        STCONFIG += link_static_$${libname} build_link_$${libname}
    }
    CONFIG -= $${ST0CONFIG}
    CONFIG += $${STCONFIG}

    #链接库自有宏，区分链接的库的重点
    LIBGROUPNAME = $$upper($${libgroupname})
    STDEFINE = $${LIBGROUPNAME}_STATIC_LIBRARY
    !equals(libname, $${libgroupname}){
        LIBNAME = $$upper($${libname})
        STDEFINE += $${LIBNAME}_STATIC_LIBRARY
    }
    DEFINES += $${STDEFINE}

    !equals(TARGET_NAME, $${libname}){
        exists($${pripath}/add_library_$${libgroupname}.pri) {
            include ($${pripath}/add_library_$${libgroupname}.pri)
            #这个位置调用肯定是SDK里的路径，但是qmake v3.1有个bug，e-linux目标，这里$${libname}有一定的概率被解析成参数1，函数名倒是还是正确的，多了个参数。
            #fix:由于library的header有是否为bundle的区别，这里无法照顾区别，不方便传参，所以，在add_library_$${libgroupname}.pri里，删除这个函数的参数，这个函数以后无参了。
            #添加头文件 参数为空，为SDK里的路径。
            add_include_$${libname}()
            #添加宏定义
            add_defines_$${libname}()
            #链接Library
            add_library_$${libname}()
        } else {
            message(please check is $${pripath}/add_library_$${libgroupname}.pri existed?)
            return (0)
        }
    } else {
        message(please check your target name $$TARGET_NAME and lib name $$libname)
        return (0)
    }

    export(CONFIG)
    export(DEFINES)

    return (1)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
defineTest(add_create_static_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    equals(libname, Template):error("User cannot create add_library_Template.pri anywhere.")

    !exists($${pripath}/add_library_$${libgroupname}.pri) {
        srcFile = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_Template.pri
        dstFile = $${pripath}/add_library_$${libgroupname}.pri
        contains(QMAKE_HOST.os, Windows) {
            srcFile = $$add_host_path($$srcFile)
            dstFile = $$add_host_path($$dstFile)
        }

        system_errcode($$COPY $${srcFile} $${dstFile}){
            message(create $$dstFile success.)
        }

        #添加自动替换的功能
    }

    add_static_dependent_manager($$libgroupname, $$libname, $$pripath)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#参数3 为空则为当前路径 $$PWD 调用处
defineTest(add_custom_static_dependent_manager){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${PWD}
    add_create_static_dependent_manager($$libgroupname, $$libname, $$pripath)
    return(1)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#默认路径是SDK ROOT下app-lib
defineTest(add_custom_static_dependent_manager2){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname
    isEmpty(pripath):pripath = $${LIB_SDK_ROOT}/app-lib
    add_create_static_dependent_manager($$libgroupname, $$libname, $$pripath)
}

#这个函数解决全部静态链接库
#lib工程，不发布库，要求链接库静态宏，不会改变当前工程的属性。
#app工程，不发布库，要求链接库静态宏，不会改变当前工程的属性。
#从默认路径加载add_library_<libgroupname>.pri
#参数1 libgroupname
#参数2 libname
#参数3 加载路径 为空则默认在multi-link/app-lib 可以自定义，比如$$PWD $${LIB_SDK_ROOT}/app-lib
defineTest(add_static_dependent_manager_v23){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    !equals(TARGET_NAME, $${libname}){
        exists($${pripath}/add_library_$${libgroupname}.pri) {
            include ($${pripath}/add_library_$${libgroupname}.pri)
            #这个位置调用肯定是SDK里的路径，但是qmake v3.1有个bug，e-linux目标，这里$${libname}有一定的概率被解析成参数1，函数名倒是还是正确的，多了个参数。
            #fix:由于library的header有是否为bundle的区别，这里无法照顾区别，不方便传参，所以，在add_library_$${libgroupname}.pri里，删除这个函数的参数，这个函数以后无参了。
            #添加头文件 参数为空，为SDK里的路径。
            add_include_$${libname}()
            #添加宏定义 参数为空，链接环中多一个这个函数
            add_static_defines_$${libname}()
            #链接Library
            add_library_$${libname}()
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

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
defineTest(add_create_static_dependent_manager_v23){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib

    equals(libname, Template):error("User cannot create add_library_Template.pri anywhere.")

    !exists($${pripath}/add_library_$${libgroupname}.pri) {
        srcFile = $${ADD_BASE_MANAGER_PRI_PWD}/../app-lib/add_library_Template_v23.pri
        dstFile = $${pripath}/add_library_$${libgroupname}.pri
        contains(QMAKE_HOST.os, Windows) {
            srcFile = $$add_host_path($$srcFile)
            dstFile = $$add_host_path($$dstFile)
        }

        system_errcode($$COPY $${srcFile} $${dstFile}){
            message(create $$dstFile success.)
        }

        #添加自动替换的功能
    }

    add_static_dependent_manager_v23($$libgroupname, $$libname, $$pripath)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#参数3 为空则为当前路径 $$PWD 调用处
defineTest(add_custom_static_dependent_manager_v23){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    #这里出现了一个bug，如果输入为空，本来设置为Template的，可是竟然不为空，Template pri也会加入。现在返回就又好了。
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $${libgroupname}
    isEmpty(pripath):pripath = $${PWD}
    add_create_static_dependent_manager_v23($$libgroupname, $$libname, $$pripath)
    return(1)
}

#如果不存在，自动创建一个模板样式的add_library_$${libgroupname}.pri
#默认路径是SDK ROOT下app-lib
defineTest(add_custom_static_dependent_manager2_v23){
    libgroupname = $$1
    libname = $$2
    pripath = $$3
    isEmpty(libgroupname):return(0)
    isEmpty(libname):libname = $$libgroupname
    isEmpty(pripath):pripath = $${LIB_SDK_ROOT}/app-lib
    add_create_static_dependent_manager_v23($$libgroupname, $$libname, $$pripath)
}

############################################################
#Multi-link内部固定的编译逻辑。
############################################################
#开启app工程 默认过程
defineTest(add_app_project) {
    #add base manager对App的处理很少，App通过函数基本上能解决所有的事情

    #macOS下开开bundle
    contains(QSYS_PRIVATE, macOS){
        CONFIG += app_bundle
    }

    export(CONFIG)
    export(DEFINES)

    return (1)
}

#开启lib工程 默认过程 DLL
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
            #不再打印
            #message(Build $${TARGET} LIB_LIBRARY is defined. build)
        } else {
            #create dynamic lib (important, only occured at builder pro)
            CONFIG += dll
            #no other one deal this, define it here, right here.
            DEFINES += LIB_LIBRARY
            #不再打印
            #message(Build $${TARGET} LIB_LIBRARY is defined. build)
        }
    #*nux platform: no macro
    } else {
        contains(QSYS_PRIVATE, macOS) {
            CONFIG += dll
            #macOS下开开bundle
            CONFIG += lib_bundle
            #fix plugin bug.
            contains(CONFIG, plugin):CONFIG -= lib_bundle
        } else:contains(QSYS_PRIVATE, iOS|iOSSimulator) {
            CONFIG += static staticlib
        } else {
            ##default build dll
            CONFIG += dll
            #*nix no need this macro
            #DEFINES += LIB_LIBRARY
        }

        #Windows的编译宏控制思路，对类Unix系统也适用，他们是兼容的，所以此处开开编译宏。
        #原先以为只有Windows用，后来发觉原来是兼容的，所以，开启。
        contains(QSYS_PRIVATE, iOS|iOSSimulator) {
            DEFINES += LIB_STATIC_LIBRARY
        } else {
            DEFINES += LIB_LIBRARY
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
    #fix plugin bug.
    contains(CONFIG, plugin):CONFIG -= create_prl

    #debug版本和release版本的所有的不同。
    #Lib的TARGET，在两个版本上有区别，通过TARGET = add_decorate_target($$TARGET)可以解决。
    #App的TARGET，在两个版本上，名字没有区别。

    export(CONFIG)
    export(DEFINES)

    return (1)
}

#默认编译为动态库 （Only lib project）
#仅仅内部状态CONFIG、宏改变，不影响链接库自有CONFIG、宏。
#=add_dynamic_library_project
#~add_lib_project，都增加了对类Unix系统的编译宏支持，和Windows的一样。是兼容的，思路一样。
defineTest(add_default_library_project) {
    #isEmpty(1): error("add_default_library_project(libgroupname) requires one argument")

    #库组的名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    #Multi-link 的内部决定CONFIG
    #删除静态设置
    CONFIG -= static staticlib
    #添加动态设置
    CONFIG += dll

    #内部状态宏的改变 这一组宏仅仅在Multi-link默认的编译过程中使用，对外部不再建议使用，建议外部使用链接库自有宏。
    DEFINES -= LIB_STATIC_LIBRARY
    #不再限制Windows平台，在类Unix平台上也使用一样的宏设置。初步在类Unix平台上还不需要，但是兼容，思路清晰。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        DEFINES += LIB_LIBRARY
        #不再打印
        #message(Build $${TARGET} LIB_LIBRARY is defined. build)
    #}

    #Multi-link 内部编译逻辑，彻底关闭提供链接库自有宏。
    #链接库自有宏的改变
    #LIBGROUPNAME = $$upper($${libgroupname})
    #LIBG1LIB = $${LIBGROUPNAME}_LIBRARY
    #LIBG1STATICLIB = $${LIBGROUPNAME}_STATIC_LIBRARY
    #DEFINES -= $${LIBG1STATICLIB}
    ##contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
    #    DEFINES += $${LIBG1LIB}
    #    #默认过程 关闭打印。如果用户发现链接库自有宏冗余，不必担心qmake宏冗余、宏删除非常人性化，增一次，加一个，删一次，全删。
    #    message(Build $${TARGET} $${LIBG1LIB} is defined. build)
    ##}

    export(CONFIG)
    export(DEFINES)
    return(1)
}

############################################################
#Multi-link内部有固定的编译逻辑，可以从这里强制改变。
#Multi-link内部默认只有在ios里，才会静态编译和链接library。
############################################################
#Multi-link内部默认为动态链接过程，LIB_LIBRARY LIB_STATIC_LIBRARY是顺便产生的内部状态宏。这个宏只能编译的时候用，对于链接工作，不能用。
#Multi-link内部状态宏，止步于工程管理，不可以给源代码用，那样不明智。
#针对本库
#这个函数以更改链接库自有宏为主，更改内部状态宏为辅。
#Multi-link v2.4 升级
#以上说法不准确，
#v2.4以前，Multi-link 提供内部CONFIG，内部状态宏，链接库自有CONFIG，链接库自有宏，三种编译状态，
#v2.4以后，由于链接库自有宏存在一个使用问题，内部的默认编译逻辑影响了自有宏的名字，外部有能力出现各种名字，现在，为了规避掉内部对用户设置的影响，我进行了升级。
#Multi-link v2.4 的默认编译逻辑，仅仅提供内部CONFIG，内部状态宏。
#链接库自有CONFIG，自有宏由用户调用以下函数产生。

#用户一般会用到内部状态宏（已废弃）、链接库自有CONFIG，链接库自有宏，那么，通过以下两个函数就可以获取到。
#内部，对外部，真正起到控制力的是CONFIG。控制动态编译、静态编译状态的两个CONFIG。
#Multi-link v2.4 通过以下两个函数，不仅提供链接库自有宏，而且，提供一组CONFIG。
#编译：build_xxxlibname, build_static_xxxlibname build_xxxlibgroupname, build_static_xxxlibgroupname
#链接：link_xxxlibname, link_static_xxxlibname link_xxxlibgroupname, link_static_xxxlibgroupname
#链接库自有CONFIG、链接库自有宏同时对链接库的编译状态起到控制作用，最终由Multi-link内部CONFIG、内部状态宏决定。
#建议使用库CONFIG、库宏，库组CONFIG、库组宏也可以使用。

#强制更换为动态库 （Only lib project）
#参数1 libgroupname 发布到的组库名称 指导一个链接库自有宏
#参数2 libname 没有修饰的 TARGET_NAME 指导一个链接库常用自有宏
defineTest(add_dynamic_library_project) {
    #isEmpty(2): error("add_dynamic_library_project(libgroupname, libname) requires two argument")

    libgroupname = $$1
    libname = $$2

    #库组的名
    isEmpty(1):libgroupname = $${TARGET_NAME}

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    #库的名
    isEmpty(2):libname = $${libgroupname}

    #Multi-link 的内部决定CONFIG
    #删除静态设置
    CONFIG -= static staticlib
    #添加动态设置
    CONFIG += dll

    #内部状态宏的改变 这一组宏仅仅在Multi-link默认的编译过程中使用，对外部不再建议使用，建议外部使用链接库自有宏。
    DEFINES -= LIB_STATIC_LIBRARY
    #不再限制Windows平台，在类Unix平台上也使用一样的宏设置。初步在类Unix平台上还不需要，但是兼容，思路清晰。
    #contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        DEFINES += LIB_LIBRARY
        #不再打印
        #message(Build $${TARGET} LIB_LIBRARY is defined. build)
    #}

    #Multi-link v2.4 提供的链接库自有CONFIG
    #组
    DY0CONFIG =
    DYCONFIG =
    DY0CONFIG += build_static_$${libgroupname} build_link_$${libgroupname}
    DYCONFIG += build_$${libgroupname}
    #TARGET
    !equals(libname, $${libgroupname}){
        DY0CONFIG += build_static_$${libname} build_link_$${libname}
        DYCONFIG += build_$${libname}
    }
    CONFIG -= $${DY0CONFIG}
    CONFIG += $${DYCONFIG}
    message(Build $${TARGET} $${DYCONFIG} is configed. build and link)

    #链接库自有宏的改变
    DY0DEF =
    DYDEF =
    LIBGROUPNAME = $$upper($${libgroupname})
    LIBG1LIB = $${LIBGROUPNAME}_LIBRARY
    LIBG1STATICLIB = $${LIBGROUPNAME}_STATIC_LIBRARY
    DY0DEF += $${LIBG1STATICLIB}
    DYDEF += $${LIBG1LIB}
    !equals(libname, $${libgroupname}){
        LIBNAME = $$upper($${libname})
        LIB1LIB = $${LIBNAME}_LIBRARY
        LIB1STATICLIB = $${LIBNAME}_STATIC_LIBRARY
        DY0DEF += $${LIB1STATICLIB}
        DYDEF += $${LIB1LIB}
    }
    DEFINES -= $${DY0DEF}
    #contains(QSYS_PRIVATE, Win32|Windows|Win64 || MSVC32|MSVC|MSVC64) {
        DEFINES += $${DYDEF}
        message(Build $${TARGET} $${DYDEF} is defined. build)
    #}

    export(CONFIG)
    export(DEFINES)
    return(1)
}

#Multi-link内部默认为动态链接过程，LIB_LIBRARY LIB_STATIC_LIBRARY是顺便产生的内部状态宏。这个宏只能编译的时候用，对于链接工作，不能用。
#针对本库
#这个函数以更改链接库自有宏为主，更改内部状态宏为辅。
#强制更换为静态库 （Only lib project）
defineTest(add_static_library_project) {
    #isEmpty(2): error("add_static_library_project(libgroupname, libname) requires two argument")

    libgroupname = $$1
    libname = $$2

    #库组的名
    isEmpty(1):libgroupname = $${TARGET_NAME}

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    #库的名
    isEmpty(2):libname = $${libgroupname}

    #Multi-link 的内部决定CONFIG
    #删除动态设置
    CONFIG -= dll
    #添加静态设置
    CONFIG += static staticlib

    #内部状态宏的改变
    DEFINES -= LIB_LIBRARY
    #不再限制Windows平台，在类Unix平台上也使用一样的宏设置。初步在类Unix平台上还不需要，但是兼容，思路清晰。
    DEFINES += LIB_STATIC_LIBRARY
    #不再打印
    #message(Build $${TARGET} LIB_STATIC_LIBRARY is defined. build and link)

    #Multi-link v2.4 提供的链接库自有CONFIG
    #组
    ST0CONFIG =
    STCONFIG =
    ST0CONFIG += build_$${libgroupname}
    STCONFIG += build_static_$${libgroupname} build_link_$${libgroupname}
    #TARGET
    !equals(libname, $${libgroupname}){
        ST0CONFIG += build_$${libname}
        STCONFIG += build_static_$${libname} build_link_$${libname}
    }
    CONFIG -= $${ST0CONFIG}
    CONFIG += $${STCONFIG}
    message(Build $${TARGET} $${STCONFIG} is configed. build and link)

    #链接库自有宏的改变
    #组
    ST0DEF =
    STDEF =
    LIBGROUPNAME = $$upper($${libgroupname})
    LIBG1LIB = $${LIBGROUPNAME}_LIBRARY
    LIBG1STATICLIB = $${LIBGROUPNAME}_STATIC_LIBRARY
    ST0DEF += $${LIBG1LIB}
    STDEF += $${LIBG1STATICLIB}
    #TARGET
    !equals(libname, $${libgroupname}){
        LIBNAME = $$upper($${libname})
        LIB1LIB = $${LIBNAME}_LIBRARY
        LIB1STATICLIB = $${LIBNAME}_STATIC_LIBRARY
        ST0DEF += $${LIB1LIB}
        STDEF += $${LIB1STATICLIB}
    }
    DEFINES -= $${ST0DEF}
    DEFINES += $${STDEF}
    message(Build $${TARGET} $${STDEF} is defined. build and link)

    export(CONFIG)
    export(DEFINES)
    return(1)
}


################################################################
##Lib Share Export Macro
################################################################
#LIBRARYSHARED_EXPORT 写在函数、类的合理位置，表示导出。
#win32目标下，这个宏的意义非常深远。

#build DEFINES += LIBRARYSHARED_EXPORT=Q_DECL_EXPORT
#link DEFINES += LIBRARYSHARED_EXPORT=Q_DECL_IMPORT
#build and link DEFINES += LIBRARYSHARED_EXPORT=
#这个定义是qmake下专有的，cmake下只需要更改下后边的Q_DECL_EXPORT

#如果需要Multi-link技术提供 LIBRARYSHARED_EXPORT，请参照README的使用说明，在用户工程中自行添加。
#一共两处，libname_header.pri，add_library_libname.pri。
#此处提供一个函数，方便用户添加LIBRARYSHARED_EXPORT宏。

#目的 解决某些工程没有library_source_global.h的问题。
#原理 链接库自有动态宏、静态宏，共同控制API导出宏的值。CONFIG - Multi-link内部状态宏/链接库自有宏 - EXPORT
#参数1 libGroupName library所属的library组名字 默认为 TARGET_NAME
#参数2 API导出宏名称 这个宏在源代码里使用 默认为[TARGET_NAME]SHARED_EXPORT
#参数3 动态宏名称 控制1 可选 [TARGET_NAME]_LIBRARY
#参数4 静态宏名称 控制2 可选 [TARGET_NAME]_STATIC_LIBRARY
defineTest(add_library_export_macro) {
    #isEmpty(1): error("add_library_export_macro(libgroupname, dymacro, stmacro, apimacro) requires at least one argument")

    #库组的名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    #Multi-link提供默认的动态编译过程
    #Multi-link提供内部状态宏 LIB_LIBRARY LIB_STATIC_LIBRARY ，但是没什么用。
    #Multi-link提供链接库自有状态宏 LIBG1NAME_LIBRARY LIBG1NAME_STATIC_LIBRARY ，编译时用，链接（依赖库）时，使用依赖库的。
    #Multi-link提供编译时、链接时，两组，4个控制编译、链接状态的函数，用户手动更改编译、链接状态。
    #所有这些宏的改变，都跟着qmake的CONFIG里的状态改变。

    #Multi-link提供链接库API导出宏，受到Multi-link提供的链接库自有动态、静态宏控制。
    #编译时一般不会有问题；链接（依赖库）时，不要用Multi-link的内部状态宏，也不要用这两个自有的。

    LIBGROUPNAME = $$upper($${libgroupname})

    APIMACRO = $$2
    isEmpty(2):APIMACRO = $${LIBGROUPNAME}SHARED_EXPORT

    DYMACRO = $$3
    isEmpty(3):DYMACRO = $${LIBGROUPNAME}_LIBRARY

    STMACRO = $$4
    isEmpty(4):STMACRO = $${LIBGROUPNAME}_STATIC_LIBRARY

    win32 {
        contains(DEFINES, $${DYMACRO}){
            #build dynamic
            DEFINES += $${APIMACRO}=Q_DECL_EXPORT
        } else: contains(DEFINES, $${STMACRO}){
            #build and link
            DEFINES += $${APIMACRO}=
        } else {
            #link dynamic
            DEFINES += $${APIMACRO}=Q_DECL_IMPORT
        }
    }

    #类Unix系统下这个宏没有意义。
    unix {
        #build and link
        DEFINES += $${APIMACRO}=
    }

    export(DEFINES)

    return (1)
}

#获取链接库动态宏名
defineReplace(add_library_dynamic_macro_name){
    #isEmpty(1): error("add_library_dynamic_macro_name(libgroupname) requires one argument")

    #库组的名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    LIBGROUPNAME = $$upper($${libgroupname})

    DYLIBNAME = $${LIBGROUPNAME}_LIBRARY
    return ($${DYLIBNAME})
}

#获取链接库静态宏名
defineReplace(add_library_static_macro_name){
    #isEmpty(1): error("add_library_static_macro_name(libgroupname) requires one argument")

    #库组的名
    libgroupname = $$TARGET_NAME
    !isEmpty(1):libgroupname=$$1

    #如果设置了 LIB_BUILD_TARGET_NAME ，那么服从 LIB_BUILD_TARGET_NAME 。
    !equals(LIB_BUILD_TARGET_NAME, $${TARGET_NAME}):libgroupname=$${LIB_BUILD_TARGET_NAME}

    LIBGROUPNAME = $$upper($${libgroupname})

    STLIBNAME = $${LIBGROUPNAME}_STATIC_LIBRARY
    return ($${STLIBNAME})
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

#<2.2时。
#帮助用户在 本地工程内部 local位置 添加头文件路径
#注意与链接第三方库的函数名称区分。
defineTest(add_include_path) {
    header_path = $$1
    isEmpty(1):header_path=$${PWD}

    INCLUDEPATH += $$header_path
    export(INCLUDEPATH)

    return (1)
}

#>=2.2时，add_include_path改名
#帮助用户在 本地工程内部 local位置 添加头文件路径
#注意与链接第三方库的函数名称区分。
defineTest(add_headers_path) {
    header_path = $$1
    isEmpty(1):header_path=$${PWD}

    INCLUDEPATH += $$header_path
    export(INCLUDEPATH)

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

#不存在就创建，存在就返回。
#create file
defineTest(add_file){
    file_name = $$1
    exists($${file_name}):return(0)
    empty_file($${file_name})
    return(1)
}
