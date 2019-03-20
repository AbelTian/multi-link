#----------------------------------------------------------------
#add_library_Qwt.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#6.1.3
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_Qwt){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(Qwt)

    command =
    #basic
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Qwt){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 Qwt 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 Qwt 的自有控制宏，
    #留意 Qwt 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 Qwt 使用的控制宏，修改 Qwt 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #Qwt比较特殊，使用QWT_DLL约束动态编译和链接。这里不定义QWT_MAKEDLL代表导入。
    #这些坑爹的二宏库，导入导出不好用。
    #qwt 动态编译。有 QWT_DLL
    #Qwt 动态编译时
    contains(DEFINES, QWT_LIBRARY){
        message($${TARGET} build Qwt dynamic library)
        DEFINES += QT_DLL QWT_DLL QWT_MAKEDLL #帮助加一次，嘿嘿。
    }
    #Qwt 静态编译、链接时
    else:contains(DEFINES, QWT_STATIC_LIBRARY){
        message($${TARGET} build-link Qwt static library)
    }
    #Qwt 动态链接时
    else:!contains(DEFINES, QWT_LIBRARY){
        message($${TARGET} link Qwt dynamic library)
        DEFINES += QT_DLL QWT_DLL #必须加一次，嘿嘿。
    }

    #--------------------------------------------
    #添加库的宏配置信息，编译时、链接时通用，需要注意区分不同宏控制
    #建议先写动态编译、链接时的通用配置，然后增加对动态编译、链接，对静态编译、链接时的兼容处理。处理多个子模块时特别好用。
    #--------------------------------------------

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_Qwt){
    #链接Library
    add_library(Qwt, Qwt$${LIBRARYVER})
    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_Qwt) {
    add_deploy_library(Qwt, Qwt$${LIBRARYVER})
    return (1)
}
