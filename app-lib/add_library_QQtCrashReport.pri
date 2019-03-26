#----------------------------------------------------------------
#add_library_QQtCrashReport.pri
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
defineTest(add_include_QQtCrashReport){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(QQtCrashReport, QQtCrashReport)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    #header_path = $$1
    header_path=$$get_add_include_bundle(QQtCrashReport, QQtCrashReport)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_QQtCrashReport){
    #添加这个SDK里的defines
    #add_defines()

    contains(DEFINES, __MSVC__){
        LIBS += -lDbgHelp
    }
    win32:msvc {
        QMAKE_LFLAGS_RELEASE = /INCREMENTAL:NO /DEBUG
    } else {
        #QMAKE_CFLAGS += -rdynamic
        #QMAKE_CXXFLAGS += -rdynamic
    }

    export(QMAKE_CFLAGS)
    export(QMAKE_CXXFLAGS)
    export(QMAKE_LFLAGS_RELEASE)
    export(LIBS)
    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_QQtCrashReport){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(QQtCrashReport, QQtCrashReport)
    add_library_bundle(QQtCrashReport, QQtCrashReport)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_QQtCrashReport) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(QQtCrashReport)
    #add_deploy_library(QQtCrashReport, QQtCrashReport)
    add_deploy_library_bundle(QQtCrashReport, QQtCrashReport)

    return (1)
}
