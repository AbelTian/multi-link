#----------------------------------------------------------------
#add_library_GoogleTest.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#1.0.0
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_GoogleTest){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(GoogleTest)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    command += $${header_path}/gtest
    command += $${header_path}/gtest/internal
    command += $${header_path}/gtest/internal/custom
    command += $${header_path}/gmock
    command += $${header_path}/gmock/internal
    command += $${header_path}/gmock/internal/custom

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_GoogleTest){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

defineTest(add_library_GoogleTest){
    #链接Library
    add_library(GoogleTest, gtest$${LIBRARYVER})
    #添加这个SDK下的其他的library
    add_library(GoogleTest, gtest_main$${LIBRARYVER})
    add_library(GoogleTest, gmock$${LIBRARYVER})
    add_library(GoogleTest, gmock_main$${LIBRARYVER})

    return (1)
}

#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_GoogleTest) {
    add_deploy_library(GoogleTest, GoogleTest$${LIBRARYVER})
    return (1)
}
