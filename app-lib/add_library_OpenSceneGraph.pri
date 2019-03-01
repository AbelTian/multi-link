#----------------------------------------------------------------
#add_library_OpenSceneGraph.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#3.4

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_OpenSceneGraph){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(OpenSceneGraph, OpenSceneGraph)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    #isEmpty(1):header_path=$$get_add_include_bundle(OpenSceneGraph, OpenSceneGraph)
    #command += $${header_path}
    
    command += $${header_path}/OpenThreads
    command += $${header_path}/osg
    command += $${header_path}/osgAnimation
    command += $${header_path}/osgDB
    command += $${header_path}/osgFX
    command += $${header_path}/osgGA
    command += $${header_path}/osgManipulator
    command += $${header_path}/osgParticle
    command += $${header_path}/osgPresentation
    command += $${header_path}/osgQt
    command += $${header_path}/osgShadow
    command += $${header_path}/osgSim
    command += $${header_path}/osgTerrain
    command += $${header_path}/osgText
    command += $${header_path}/osgUI
    command += $${header_path}/osgUtil
    command += $${header_path}/osgViewer
    command += $${header_path}/osgViewer/api
    command += $${header_path}/osgViewer/api/Win32
    command += $${header_path}/osgViewer/config
    command += $${header_path}/osgVolume
    command += $${header_path}/osgWidget

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_OpenSceneGraph){
    #添加这个SDK里的defines
    #add_defines()


    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_static_defines_OpenSceneGraph){
    #如果链接静态库，那么开启。编译也开启。
    DEFINES += OPENSCENEGRAPH_STATIC_LIBRARY

    add_defines_OpenSceneGraph()

    export(DEFINES)
    return (1)
}

#留意
defineTest(add_library_OpenSceneGraph){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(OpenSceneGraph, OpenSceneGraph)
    
    add_library(OpenSceneGraph, OpenThreads)
    add_library(OpenSceneGraph, osg)
    add_library(OpenSceneGraph, osgAnimation)
    add_library(OpenSceneGraph, osgDB)
    add_library(OpenSceneGraph, osgFX)
    add_library(OpenSceneGraph, osgGA)
    add_library(OpenSceneGraph, osgManipulator)
    add_library(OpenSceneGraph, osgParticle)
    add_library(OpenSceneGraph, osgPresentation)
    add_library(OpenSceneGraph, osgQt)
    add_library(OpenSceneGraph, osgShadow)
    add_library(OpenSceneGraph, osgSim)
    add_library(OpenSceneGraph, osgTerrain)
    add_library(OpenSceneGraph, osgText)
    add_library(OpenSceneGraph, osgUI)
    add_library(OpenSceneGraph, osgUtil)
    add_library(OpenSceneGraph, osgViewer)
    add_library(OpenSceneGraph, osgVolume)
    add_library(OpenSceneGraph, osgWidget)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_OpenSceneGraph) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_library(OpenSceneGraph, OpenSceneGraph)
    #add_deploy_libraryes(OpenSceneGraph)
    
    add_deploy_library(OpenSceneGraph, OpenThreads)
    add_deploy_library(OpenSceneGraph, osg)
    add_deploy_library(OpenSceneGraph, osgAnimation)
    add_deploy_library(OpenSceneGraph, osgDB)
    add_deploy_library(OpenSceneGraph, osgFX)
    add_deploy_library(OpenSceneGraph, osgGA)
    add_deploy_library(OpenSceneGraph, osgManipulator)
    add_deploy_library(OpenSceneGraph, osgParticle)
    add_deploy_library(OpenSceneGraph, osgPresentation)
    add_deploy_library(OpenSceneGraph, osgQt)
    add_deploy_library(OpenSceneGraph, osgShadow)
    add_deploy_library(OpenSceneGraph, osgSim)
    add_deploy_library(OpenSceneGraph, osgTerrain)
    add_deploy_library(OpenSceneGraph, osgText)
    add_deploy_library(OpenSceneGraph, osgUI)
    add_deploy_library(OpenSceneGraph, osgUtil)
    add_deploy_library(OpenSceneGraph, osgViewer)
    add_deploy_library(OpenSceneGraph, osgVolume)
    add_deploy_library(OpenSceneGraph, osgWidget)

    return (1)
}