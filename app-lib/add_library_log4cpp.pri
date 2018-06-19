#----------------------------------------------------------------
#add_library_log4cpp.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#1.0.0
LIBRARYVER = .5

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_log4cpp){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path):header_path=$$get_add_include(log4cpp)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    command += $${header_path}/..
    command += $${header_path}/threading

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_log4cpp){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

defineTest(add_library_log4cpp){
    add_library(log4cpp, log4cpp$${LIBRARYVER})

    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_log4cpp) {
    add_deploy_library(log4cpp, log4cpp$${LIBRARYVER})
    return (1)
}
