#----------------------------------------------------------------
#add_library_FLTK.pri
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
defineTest(add_include_FLTK){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path)header_path=$$get_add_include(FLTK, FLTK)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    command += $${header_path}/images

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_FLTK){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
defineTest(add_library_FLTK){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(FLTK, FLTK)
    add_library(FLTK, fltk)
    add_library(FLTK, fltk_forms)
    add_library(FLTK, fltk_gl)
    add_library(FLTK, fltk_images)
    add_library(FLTK, fltk_jpeg)
    add_library(FLTK, fltk_png)
    add_library(FLTK, fltk_z)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_FLTK) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_library(FLTK, FLTK)
    #add_deploy_libraryes(FLTK)
    add_deploy_library(FLTK, fltk)
    add_deploy_library(FLTK, fltk_forms)
    add_deploy_library(FLTK, fltk_gl)
    add_deploy_library(FLTK, fltk_images)
    add_deploy_library(FLTK, fltk_jpeg)
    add_deploy_library(FLTK, fltk_png)
    add_deploy_library(FLTK, fltk_z)

    return (1)
}