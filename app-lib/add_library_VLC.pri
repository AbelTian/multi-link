#----------------------------------------------------------------
#add_library_VLC.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#1.1.0
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
defineTest(add_include_VLC){
    isEmpty(1)|!isEmpty(2) : error("add_include_VLC(path) requires one arguments.")
    path = $$1

    command =
    #basic
    command += $${path}
    #这里添加$${path}下的子文件夹
    command += $${path}/VLCQtCore
    command += $${path}/VLCQtWidgets

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}


defineTest(add_library_VLC) {
    #链接Library
    add_library(VLC, VLCQtCore$${LIBRARYVER})
    add_library(VLC, VLCQtWidgets$${LIBRARYVER})
    return (1)
}

#######################################################################################
#定义外部函数
#######################################################################################
#链接VLC的WorkFlow
defineTest(add_link_library_VLC) {
    #链接Library
    add_library_VLC()

    #添加头文件 （如果头文件目录扩展了，就改这个函数）
    header_path = $$get_add_include(VLC)
    add_include_VLC($$header_path)
    #这样包含也很好，简洁明了
    #add_include(VLC, VLCQtCore)
    #add_include(VLC, VLCQtWidgets)
    #...

    #添加宏定义
    #add_defines(xx)
    return (1)
}

#发布依赖library的函数
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_VLC) {
    add_deploy_libraryes(VLC)
    return (1)
}

defineTest(add_dependent_library_VLC) {
    add_link_library_VLC()
    add_deploy_library_VLC()
    return (1)
}

#######################################################################################
#定义额外函数
#######################################################################################
#留意
#这个给Library导出include和defines用，和链接这个Library无关，一般在Library生产线使用。
defineTest(add_export_library_VLC){
    header_path = $$1
    isEmpty(header_path):return(0)
    #添加头文件 （如果头文件目录扩展了，就改这个函数）
    add_include_VLC($$header_path)
    #添加宏定义
    add_defines_VLC()
    return (1)
}
