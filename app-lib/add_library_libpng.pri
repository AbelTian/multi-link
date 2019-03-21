#----------------------------------------------------------------
#add_library_libpng.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#VER=16

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_libpng){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(libpng, libpng)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(libpng, png)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_libpng){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 libpng 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 libpng 的自有控制宏，
    #留意 libpng 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 libpng 使用的控制宏，修改 libpng 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #libpng 动态编译时
    contains(DEFINES, LIBPNG_LIBRARY){
        message($${TARGET} build libpng dynamic library)
        DEFINES += PNG_USE_DLL
        DEFINES += PNG_IMPEXP=PNG_DLL_EXPORT
    }
    #libpng 静态编译、链接时
    else:contains(DEFINES, LIBPNG_STATIC_LIBRARY){
        message($${TARGET} build-link libpng static library)
    }
    #libpng 动态链接时
    else:!contains(DEFINES, LIBPNG_LIBRARY){
        message($${TARGET} link libpng dynamic library)
        DEFINES += PNG_USE_DLL
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
defineTest(add_library_libpng){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(libpng, libpng)
    add_library(libpng, png)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_libpng) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(libpng)
    #add_deploy_library(libpng, libpng)
    add_deploy_library(libpng, png)

    return (1)
}
