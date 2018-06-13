#----------------------------------------------------------------
#add_library_OGRE.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#1
LIBRARYVER =

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_OGRE){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path)header_path=$$get_add_include(OGRE, OGRE)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    command += $${header_path}/Bites
    command += $${header_path}/HLMS
    command += $${header_path}/MeshLodGenerator
    command += $${header_path}/Overlay
    command += $${header_path}/Paging
    command += $${header_path}/Plugins
    command += $${header_path}/Plugins/BSPSceneManager
    command += $${header_path}/Plugins/OctreeSceneManager
    command += $${header_path}/Plugins/OctreeZone
    command += $${header_path}/Plugins/ParticleFX
    command += $${header_path}/Plugins/PCZSceneManager
    command += $${header_path}/Plugins/STBICodec

    command += $${header_path}/Property
    command += $${header_path}/RenderSystems
    command += $${header_path}/RenderSystems/Direct3D9
    command += $${header_path}/RenderSystems/Direct3D11
    command += $${header_path}/RenderSystems/GL
    command += $${header_path}/RenderSystems/GL/GL
    command += $${header_path}/RenderSystems/GL3Plus
    command += $${header_path}/RenderSystems/GL3Plus/GL

    command += $${header_path}/RTShaderSystem
    command += $${header_path}/Terrain
    command += $${header_path}/Threading
    command += $${header_path}/Volume

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_OGRE){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
#这个地方add_library_bundle代表 macOS下，lib在bundle里。
defineTest(add_library_OGRE){
    #添加这个SDK里的library
    add_library(OGRE, OgreBites$${LIBRARYVER})
    add_library(OGRE, OgreGLSupport$${LIBRARYVER})
    add_library(OGRE, OgreHLMS$${LIBRARYVER})
    add_library(OGRE, OgreMain$${LIBRARYVER})
    add_library(OGRE, OgreMeshLodGenerator$${LIBRARYVER})
    add_library(OGRE, OgreOverlay$${LIBRARYVER})
    add_library(OGRE, OgrePaging$${LIBRARYVER})
    add_library(OGRE, OgreProperty$${LIBRARYVER})
    add_library(OGRE, OgreRTShaderSystem$${LIBRARYVER})
    add_library(OGRE, OgreTerrain$${LIBRARYVER})
    add_library(OGRE, OgreVolume$${LIBRARYVER})

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_OGRE) {
    add_deploy_libraryes(OGRE, OGRE$${LIBRARYVER})
    #add_deploy_libraryes(OGRE)
    return (1)
}
