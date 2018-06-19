#----------------------------------------------------------------
#add_library_SDL2.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#2
LIBRARYVER =

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_SDL2){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path):header_path=$$get_add_include_bundle(SDL2)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    command += $${header_path}/..
    #额外的方法
    #这个是有点分歧，其实mac下SDL2 framwrok里的Headers就够用了，可是某些程序当中喜欢把头文件带SDL2字样，bundle里面没有，所以出现了下边这个inc和上边这个inc并存的情况。
    add_include_bundle(SDL2, SDL2)

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_SDL2){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
#这个地方add_library_bundle代表 macOS下，lib在bundle里。
defineTest(add_library_SDL2){
    #添加这个SDK里的library
    add_library_bundle(SDL2, SDL2$${LIBRARYVER})

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_SDL2) {
    #跟随app发布SDL2的具体的library
    add_deploy_library_bundle(SDL2, SDL2$${LIBRARYVER})
    #add_deploy_libraryes(SDL2)
    return (1)
}

