#----------------------------------------------------------------
#add_library_Qwt.pri
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
defineTest(add_include_Qwt){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(Qwt)

    command =
    #basic
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Qwt){
    #添加这个SDK里的defines
    #add_defines()

    #Qwt比较特殊，使用QWT_DLL约束动态编译和链接。这里不定义QWT_MAKEDLL代表导入。
    contains(DEFINES, __WIN__){
        #这些坑爹的二宏库，导入导出不好用。
        #qwt 动态编译。有 QWT_DLL
        contains(DEFINES, QWT_MAKEDLL){
            message(build qwt dynamic library)
            DEFINES += QT_DLL QWT_DLL #帮助加一次，嘿嘿。
        }
        #如果定义编译静态库，那么开启。没有ZLIB_DLL。
        else:contains(DEFINES, QWT_STATIC_LIBRARY):message(build and link qwt static library)
        #qwt 动态链接。 app也需要 QWT_DLL 宏 user-lib也需要 QWT_DLL 宏
        else:!contains(DEFINES, QWT_MAKEDLL){
            message(link qwt dynamic library)
            DEFINES += QT_DLL QWT_DLL #必须加一次，嘿嘿。
        }
    }

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_static_defines_Qwt){
    #如果链接静态库，那么开启。编译也开启。
    DEFINES += QWT_STATIC_LIBRARY

    add_defines_Qwt()

    export(DEFINES)
    return (1)
}

#留意
defineTest(add_library_Qwt){
    #链接Library
    add_library(Qwt, Qwt$${LIBRARYVER})
    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_Qwt) {
    add_deploy_library(Qwt, Qwt$${LIBRARYVER})
    return (1)
}
