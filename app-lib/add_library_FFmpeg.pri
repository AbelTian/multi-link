#----------------------------------------------------------------
#add_library_FFmpeg.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#3.2

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_FFmpeg){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(FFmpeg, FFmpeg)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(FFmpeg, FFmpeg)
    command += $${header_path}
    #这里需要引起猛烈的注意
    #如果包含了这些目录，gcc会检测到和系统头文件重名的冲突而无法编译通过。
    #我编译了很久总是报告头文件冲突，就是因为这里，如果有个after选项，把这些目录after加到系统头文件后边就好了。
    #command += $${header_path}/libavcodec
    #command += $${header_path}/libavdevice
    #command += $${header_path}/libavfilter
    #command += $${header_path}/libavformat
    #command += $${header_path}/libavutil
    #command += $${header_path}/libpostproc
    #command += $${header_path}/libswresample
    #command += $${header_path}/libswscale

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_FFmpeg){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 FFmpeg 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 FFmpeg 的自有控制宏，
    #留意 FFmpeg 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 FFmpeg 使用的控制宏，修改 FFmpeg 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #FFmpeg 动态编译时
    contains(DEFINES, FFMPEG_LIBRARY){
        message($${TARGET} build FFmpeg dynamic library)
    }
    #FFmpeg 静态编译、链接时
    else:contains(DEFINES, FFMPEG_STATIC_LIBRARY){
        message($${TARGET} build-link FFmpeg static library)
    }
    #FFmpeg 动态链接时
    else:!contains(DEFINES, FFMPEG_LIBRARY){
        message($${TARGET} link FFmpeg dynamic library)
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
defineTest(add_library_FFmpeg){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(FFmpeg, FFmpeg)
    add_library(FFmpeg, avcodec)
    add_library(FFmpeg, avdevice)
    add_library(FFmpeg, avfilter)
    add_library(FFmpeg, avformat)
    add_library(FFmpeg, avutil)
    add_library(FFmpeg, swresample)
    add_library(FFmpeg, swscale)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_FFmpeg) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(FFmpeg)
    #add_deploy_library(FFmpeg, FFmpeg)
    add_deploy_library(FFmpeg, avcodec*)
    add_deploy_library(FFmpeg, avdevice*)
    add_deploy_library(FFmpeg, avfilter*)
    add_deploy_library(FFmpeg, avformat*)
    add_deploy_library(FFmpeg, avutil*)
    add_deploy_library(FFmpeg, swresample*)
    add_deploy_library(FFmpeg, swscale*)

    return (1)
}
