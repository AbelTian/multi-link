#----------------------------------------------------------------
#add_library_Template.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#1.0.0
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_Template){
    isEmpty(1)|!isEmpty(2) : error("add_include_Template(path) requires one arguments.")
    path = $$1

    command =
    #basic
    command += $${path}
    #这里添加$${path}下的子文件夹

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Template){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
#这个地方add_library_bundle代表包括macOS下，lib在bundle里。
defineTest(add_library_Template){
    #添加这个SDK里的library
    add_library_bundle(Template, Template$${LIBRARYVER})

    return (1)
}

#######################################################################################
#定义外部函数
#######################################################################################
#链接Template的WorkFlow
#留意
defineTest(add_link_library_Template){
    #添加宏定义
    add_defines_Template()
    #添加头文件 （如果头文件目录扩展了，就改这个函数）
    #这里，add_include_bundle代表macOS下，Library的头文件在bundle里
    header_path = $$get_add_include_bundle(Template)
    add_include_Template($$header_path)
    return (1)
    #链接Library
    add_library_Template()
    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_Template) {
    add_deploy_library(Template, Template$${LIBRARYVER})
    #add_deploy_libraryes(Template)
    return (1)
}

defineTest(add_dependent_library_Template) {
    add_link_library_Template()
    add_deploy_library_Template()
    return (1)
}

#######################################################################################
#定义额外函数
#######################################################################################
#留意
#这个给Library导出include和defines用，和链接这个Library无关，一般在Library生产线使用。
defineTest(add_export_library_Template){
    header_path = $$1
    isEmpty(header_path):return(0)
    #添加头文件 （如果头文件目录扩展了，就改这个函数）
    add_include_Template($$header_path)
    #添加宏定义
    add_defines_Template()
    return (1)
}
