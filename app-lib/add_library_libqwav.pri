#----------------------------------------------------------------
#add_library_libqwav.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################


#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_libqwav){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(libqwav, libqwav)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(libqwav, libqwav)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_libqwav){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 libqwav 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 libqwav 使用的控制宏，修改 libqwav 编译时、链接时的不同的宏配置
    #可以用于转换使用不同宏、两套宏控制的链接库
    #--------------------------------------------
    #libqwav 动态编译时
    contains(DEFINES, LIBQWAV_LIBRARY){
        message(build libqwav dynamic library)
    }
    #libqwav 静态编译、链接时
    else:contains(DEFINES, LIBQWAV_STATIC_LIBRARY){
        message(build and link libqwav static library)
    }
    #libqwav 动态链接时
    else:!contains(DEFINES, LIBQWAV_LIBRARY){
        message(link libqwav dynamic library)
    }

    #--------------------------------------------
    #添加库的宏配置信息，编译时、链接时通用，需要注意区分不同宏控制
    #--------------------------------------------

    return (1)
}

#修改
defineTest(add_library_libqwav){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(libqwav, libqwav)
    add_library(libqwav, libqwav)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_libqwav) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(libqwav)
    #add_deploy_library(libqwav, libqwav)
    add_deploy_library(libqwav, libqwav)

    return (1)
}
