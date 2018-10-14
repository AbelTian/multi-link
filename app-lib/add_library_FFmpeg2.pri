#----------------------------------------------------------------
#add_library_FFmpeg2.pri
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
defineTest(add_include_FFmpeg2){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(FFmpeg2, FFmpeg2)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(FFmpeg2, FFmpeg2)
    command += $${header_path}
    #command += $${header_path}/libavcodec
    #command += $${header_path}/libavdevice
    #command += $${header_path}/libavfilter
    #command += $${header_path}/libavformat
    #command += $${header_path}/libavutil
    #command += $${header_path}/libswresample
    #command += $${header_path}/libswscale

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_FFmpeg2){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
defineTest(add_library_FFmpeg2){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(FFmpeg2, FFmpeg2)
    add_library(FFmpeg2, avcodec)
    add_library(FFmpeg2, avdevice)
    add_library(FFmpeg2, avfilter)
    add_library(FFmpeg2, avformat)
    add_library(FFmpeg2, avutil)
    add_library(FFmpeg2, swresample)
    add_library(FFmpeg2, swscale)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_FFmpeg2) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(FFmpeg2)
    #add_deploy_library(FFmpeg2, FFmpeg2)
    add_deploy_library(FFmpeg2, avcodec-57)
    add_deploy_library(FFmpeg2, avdevice-57)
    add_deploy_library(FFmpeg2, avfilter-6)
    add_deploy_library(FFmpeg2, avformat-57)
    add_deploy_library(FFmpeg2, avutil-55)
    add_deploy_library(FFmpeg2, postproc-54)
    add_deploy_library(FFmpeg2, swresample-2)
    add_deploy_library(FFmpeg2, swscale-4)

    return (1)
}
