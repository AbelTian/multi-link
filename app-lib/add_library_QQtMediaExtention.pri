#----------------------------------------------------------------
#add_library_QQtMediaExtention.pri
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
defineTest(add_include_QQtMediaExtention){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(QQtMediaExtention, QQtMediaExtention)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    #header_path = $$1
    header_path=$$get_add_include_bundle(QQtMediaExtention, QQtMediaExtention)
    command += $${header_path}
    command += $${header_path}/QQtFFmpeg
    command += $${header_path}/QQtPhonon

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_QQtMediaExtention){
    #添加这个SDK里的defines
    #add_defines()

    #QQtMedia Module
    #DEFINES += __QQT_MEDIA__
    contains(DEFINES, __QQT_MEDIA__) {
        #add_dependent_manager(FFmpeg2)
        #add_dependent_manager(SDL)
    }

    #QtMedia Module
    #这个是Qt5默认的媒体
    #DEFINES += __QT_MEDIA__
    contains(DEFINES, __QT_MEDIA__) {
        #e-linux 依赖gstreamer
        QT += multimedia
    }

    #Phonon Module
    #这个是Qt4默认的媒体
    #DEFINES += __PHONON_MEDIA__
    contains(DEFINES, __PHONON_MEDIA__) {
        #e-linux 依赖gstreamer
        QT += phonon
    }

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_QQtMediaExtention){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(QQtMediaExtention, QQtMediaExtention)
    add_library_bundle(QQtMediaExtention, QQtMediaExtention)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_QQtMediaExtention) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(QQtMediaExtention)
    #add_deploy_library(QQtMediaExtention, QQtMediaExtention)
    add_deploy_library_bundle(QQtMediaExtention, QQtMediaExtention)

    return (1)
}
