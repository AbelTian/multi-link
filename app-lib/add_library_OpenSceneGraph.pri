#----------------------------------------------------------------
#add_library_OpenSceneGraph.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
#3.4
LIBRARYVER =

#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_OpenSceneGraph){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path)header_path=$$get_add_include(OpenSceneGraph)

    command =
    #basic
    command += $${header_path}
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

    return (1)
}


defineTest(add_library_OpenSceneGraph) {
    #链接Library
    add_library(OpenSceneGraph, OpenThreads$${LIBRARYVER})
    add_library(OpenSceneGraph, osg$${LIBRARYVER})
    add_library(OpenSceneGraph, osgAnimation$${LIBRARYVER})
    add_library(OpenSceneGraph, osgDB$${LIBRARYVER})
    add_library(OpenSceneGraph, osgFX$${LIBRARYVER})
    add_library(OpenSceneGraph, osgGA$${LIBRARYVER})
    add_library(OpenSceneGraph, osgManipulator$${LIBRARYVER})
    add_library(OpenSceneGraph, osgParticle$${LIBRARYVER})
    add_library(OpenSceneGraph, osgPresentation$${LIBRARYVER})
    add_library(OpenSceneGraph, osgQt$${LIBRARYVER})
    add_library(OpenSceneGraph, osgShadow$${LIBRARYVER})
    add_library(OpenSceneGraph, osgSim$${LIBRARYVER})
    add_library(OpenSceneGraph, osgTerrain$${LIBRARYVER})
    add_library(OpenSceneGraph, osgText$${LIBRARYVER})
    add_library(OpenSceneGraph, osgUI$${LIBRARYVER})
    add_library(OpenSceneGraph, osgUtil$${LIBRARYVER})
    add_library(OpenSceneGraph, osgViewer$${LIBRARYVER})
    add_library(OpenSceneGraph, osgVolume$${LIBRARYVER})
    add_library(OpenSceneGraph, osgWidget$${LIBRARYVER})
    return (1)
}

#发布依赖library的函数
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_OpenSceneGraph) {
    add_deploy_libraryes(OpenSceneGraph)
    return (1)
}
