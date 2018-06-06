#----------------------------------------------------------------
#add_library_FFmpeg3.2.pri
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
defineReplace(get_add_include_FFmpeg3.2){
    path = $$1
    isEmpty(1)|!isEmpty(2) : error("get_add_include_FFmpeg3.2(path) requires one arguments.")

    command =
    #basic
    command += $${path}
    command += $${path}/..
    command += $${path}/libavcodec
    command += $${path}/libavdevice
    command += $${path}/libavfilter
    command += $${path}/libavformat
    command += $${path}/libavutil
    command += $${path}/libpostproc
    command += $${path}/libswresample
    command += $${path}/libswscale

    return ($$command)
}

defineTest(add_include_FFmpeg3.2){
    #包含FFmpeg3.2头文件的过程
    header_path = $$get_add_include(FFmpeg3.2)
    INCLUDEPATH += $$get_add_include_FFmpeg3.2($$header_path)
    export(INCLUDEPATH)
    return (1)
}

defineTest(add_library_FFmpeg3.2) {
    #链接Library
    add_library(FFmpeg3.2, avcodec)
    add_library(FFmpeg3.2, avdevice)
    add_library(FFmpeg3.2, avfilter)
    add_library(FFmpeg3.2, avformat)
    add_library(FFmpeg3.2, avutil)
    add_library(FFmpeg3.2, postproc)
    add_library(FFmpeg3.2, swresample)
    add_library(FFmpeg3.2, swscale)

    return (1)
}

#######################################################################################
#定义外部函数
#######################################################################################
#链接FFmpeg3.2的WorkFlow
defineTest(add_link_library_FFmpeg3.2) {
    #链接Library
    add_library_FFmpeg3.2()

    #添加头文件 （如果头文件目录扩展了，就改这个函数）
    add_include_FFmpeg3.2()
    #这样包含也很好，简洁明了
    #add_include(FFmpeg3.2, FFmpeg3.2QtCore)
    #add_include(FFmpeg3.2, FFmpeg3.2QtWidgets)
    #...

    #添加宏定义
    #add_defines(xx)
    return (1)
}

#发布依赖library的函数
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_FFmpeg3.2) {
    add_deploy_libraryes(FFmpeg3.2)
    return (1)
}

defineTest(add_dependent_library_FFmpeg3.2) {
    add_link_library_FFmpeg3.2()
    add_deploy_library_FFmpeg3.2()
    return (1)
}
