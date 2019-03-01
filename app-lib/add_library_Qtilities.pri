#----------------------------------------------------------------
#add_library_Qtilities.pri
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
defineTest(add_include_Qtilities){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(Qtilities, Qtilities)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesCore)
    command += $${header_path}
    
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesCoreGui)
    command += $${header_path}
    
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesExtensionSystem)
    command += $${header_path}
    
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesLogging)
    command += $${header_path}
    
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesProjectManagement)
    command += $${header_path}
    
    header_path=$$get_add_include_bundle(Qtilities, QtilitiesTesting)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Qtilities){
    #添加这个SDK里的defines
    #add_defines()


    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_static_defines_Qtilities){
    #如果链接静态库，那么开启。编译也开启。
    DEFINES += QTILITIES_STATIC_LIBRARY

    add_defines_Qtilities()

    export(DEFINES)
    return (1)
}

#留意
defineTest(add_library_Qtilities){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(Qtilities, Qtilities)
    add_library_bundle(Qtilities, QtilitiesCore)
    add_library_bundle(Qtilities, QtilitiesCoreGui)
    add_library_bundle(Qtilities, QtilitiesExtensionSystem)
    add_library_bundle(Qtilities, QtilitiesLogging)
    add_library_bundle(Qtilities, QtilitiesProjectManagement)
    add_library_bundle(Qtilities, QtilitiesTesting)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_Qtilities) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(Qtilities)
    #add_deploy_library(Qtilities, Qtilities)
    add_deploy_library_bundle(Qtilities, QtilitiesCore)
    add_deploy_library_bundle(Qtilities, QtilitiesCoreGui)
    add_deploy_library_bundle(Qtilities, QtilitiesExtensionSystem)
    add_deploy_library_bundle(Qtilities, QtilitiesLogging)
    add_deploy_library_bundle(Qtilities, QtilitiesProjectManagement)
    add_deploy_library_bundle(Qtilities, QtilitiesTesting)

    return (1)
}