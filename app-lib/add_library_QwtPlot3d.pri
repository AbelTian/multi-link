#----------------------------------------------------------------
#add_library_QwtPlot3d.pri
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
defineTest(add_include_QwtPlot3d){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(QwtPlot3d)

    command =
    #basic
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_QwtPlot3d){
    #添加这个SDK里的defines
    #add_defines()
    #Qwt3D比较特殊，使用QWT3D_DLL约束动态编译和链接。这里不定义QWT3D_MAKEDLL代表导入。
    DEFINES += QT_DLL QWT3D_DLL
    
    return (1)
}

defineTest(add_library_QwtPlot3d){
    #链接Library
    add_library(QwtPlot3d, QwtPlot3d$${LIBRARYVER})
    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_QwtPlot3d) {
    add_deploy_library(QwtPlot3d, QwtPlot3d$${LIBRARYVER})
    return (1)
}
