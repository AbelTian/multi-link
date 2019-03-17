#----------------------------------------------------------------
#add_library_zlib.pri
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
defineTest(add_include_zlib){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(zlib, zlib)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(zlib, z)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_zlib){
    #添加这个SDK里的defines
    #add_defines()

    contains(DEFINES, __WIN__){
        #这些坑爹的二宏库，导入导出不好用，要做转换。
        contains(DEFINES, ZLIB_LIBRARY){
            message($$TARGET build zlib dynamic library)
            #zlib动态编译。有ZLIB_DLL
            DEFINES += ZLIB_DLL ZLIB_INTERNAL #帮助加一次，嘿嘿。
        }
        else:contains(DEFINES, ZLIB_STATIC_LIBRARY){
            #如果定义编译静态库，那么开启。没有ZLIB_DLL。
            message($$TARGET build-link zlib static library)
        } else:!contains(DEFINES, ZLIB_LIBRARY){
            message($$TARGET link zlib dynamic library)
            #zlib动态链接。 app也需要ZLIB_DLL宏 user-lib也需要ZLIB_DLL宏
            DEFINES += ZLIB_DLL #必须加一次，嘿嘿。
        }
    }

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_zlib){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(zlib, zlib)
    add_library(zlib, z)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_zlib) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(zlib)
    #add_deploy_library(zlib, zlib)
    add_deploy_library(zlib, z)

    return (1)
}
