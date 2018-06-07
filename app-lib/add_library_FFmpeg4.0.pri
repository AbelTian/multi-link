#----------------------------------------------------------------
#add_library_FFmpeg4.0.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------


#######################################################################################
#初始化设置
#######################################################################################
#4.0
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
defineTest(add_include_FFmpeg4.0){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path)header_path=$$get_add_include(FFmpeg4.0)

    command =
    #basic
    command += $${header_path}
    command += $${header_path}/..
    command += $${header_path}/libavcodec
    command += $${header_path}/libavdevice
    command += $${header_path}/libavfilter
    command += $${header_path}/libavformat
    command += $${header_path}/libavutil
    command += $${header_path}/libpostproc
    command += $${header_path}/libswresample
    command += $${header_path}/libswscale

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_FFmpeg4.0){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

defineTest(add_library_FFmpeg4.0) {
    #链接Library
    add_library(FFmpeg4.0, avcodec)
    add_library(FFmpeg4.0, avdevice)
    add_library(FFmpeg4.0, avfilter)
    add_library(FFmpeg4.0, avformat)
    add_library(FFmpeg4.0, avutil)
    add_library(FFmpeg4.0, postproc)
    add_library(FFmpeg4.0, swresample)
    add_library(FFmpeg4.0, swscale)

    return (1)
}


#发布依赖library的函数
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_FFmpeg4.0) {
    add_deploy_library(FFmpeg4.0, avcodec)
    add_deploy_library(FFmpeg4.0, avdevice)
    add_deploy_library(FFmpeg4.0, avfilter)
    add_deploy_library(FFmpeg4.0, avformat)
    add_deploy_library(FFmpeg4.0, avutil)
    add_deploy_library(FFmpeg4.0, postproc)
    add_deploy_library(FFmpeg4.0, swresample)
    add_deploy_library(FFmpeg4.0, swscale)
    return (1)
}
