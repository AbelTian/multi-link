#----------------------------------------------------------------
#add_library_log4cpp.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#1.0.0
LIBRARYVER = .5

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_log4cpp){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(log4cpp)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    command += $${header_path}/..
    command += $${header_path}/threading

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_log4cpp){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 log4cpp 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 log4cpp 的自有控制宏，
    #留意 log4cpp 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 log4cpp 使用的控制宏，修改 log4cpp 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #log4cpp 动态编译时
    contains(DEFINES, LOG4CPP_LIBRARY){
        message($${TARGET} build log4cpp dynamic library)
    }
    #log4cpp 静态编译、链接时
    else:contains(DEFINES, LOG4CPP_STATIC_LIBRARY){
        message($${TARGET} build-link log4cpp static library)
    }
    #log4cpp 动态链接时
    else:!contains(DEFINES, LOG4CPP_LIBRARY){
        message($${TARGET} link log4cpp dynamic library)
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
defineTest(add_library_log4cpp){
    add_library(log4cpp, log4cpp$${LIBRARYVER})

    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_log4cpp) {
    add_deploy_library(log4cpp, log4cpp$${LIBRARYVER})
    return (1)
}
