#----------------------------------------------------------------
#add_library_halcon12.pri
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
defineTest(add_include_halcon12){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(halcon12, halcon12)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(halcon12, halcon12)
    command += $${header_path}
    command += $${header_path}/com
    command += $${header_path}/cpp
    command += $${header_path}/halconc
    command += $${header_path}/halconcpp
    command += $${header_path}/hdevengine
    command += $${header_path}/hdevengine10
    command += $${header_path}/hlib

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_halcon12){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
defineTest(add_library_halcon12){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(halcon12, halcon12)
    add_library(halcon12, halcon)
    add_library(halcon12, halconc)
    add_library(halcon12, halconcpp)
    add_library(halcon12, halconcpp10)
    add_library(halcon12, halconcpp10xl)
    add_library(halcon12, halconcppxl)
    add_library(halcon12, halconcxl)
    add_library(halcon12, halconx)
    add_library(halcon12, halconxl)
    add_library(halcon12, halconxxl)
    add_library(halcon12, hdevenginecpp)
    add_library(halcon12, hdevenginecpp10)
    add_library(halcon12, hdevenginecpp10xl)
    add_library(halcon12, hdevenginecppxl)
    add_library(halcon12, hdevenginex)
    add_library(halcon12, hdevenginexxl)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_halcon12) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(halcon12)
    #add_deploy_library(halcon12, halcon12)
    add_deploy_library(halcon12, halcon)
    add_deploy_library(halcon12, halconc)
    add_deploy_library(halcon12, halconcpp)
    add_deploy_library(halcon12, halconcpp10)
    add_deploy_library(halcon12, halconcpp10xl)
    add_deploy_library(halcon12, halconcppxl)
    add_deploy_library(halcon12, halconcxl)
    add_deploy_library(halcon12, halconx)
    add_deploy_library(halcon12, halconxl)
    add_deploy_library(halcon12, halconxxl)
    add_deploy_library(halcon12, hdevenginecpp)
    add_deploy_library(halcon12, hdevenginecpp10)
    add_deploy_library(halcon12, hdevenginecpp10xl)
    add_deploy_library(halcon12, hdevenginecppxl)
    add_deploy_library(halcon12, hdevenginex)
    add_deploy_library(halcon12, hdevenginexxl)

    return (1)
}