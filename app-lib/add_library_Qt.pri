#----------------------------------------------------------------
#add_library_Qt.pri
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
defineTest(add_include_Qt){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(Qt, Qt)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    #header_path = $$1
    header_path=$$get_add_include_bundle(Qt, Qt3DAnimation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DAnimation
    command += $${header_path}/5.9.2/Qt3DAnimation/private
    header_path=$$get_add_include_bundle(Qt, Qt3DCore)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DCore
    command += $${header_path}/5.9.2/Qt3DCore/private
    header_path=$$get_add_include_bundle(Qt, Qt3DExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DExtras
    command += $${header_path}/5.9.2/Qt3DExtras/private
    header_path=$$get_add_include_bundle(Qt, Qt3DInput)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DInput
    command += $${header_path}/5.9.2/Qt3DInput/private
    header_path=$$get_add_include_bundle(Qt, Qt3DLogic)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DLogic
    command += $${header_path}/5.9.2/Qt3DLogic/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuick)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuick
    command += $${header_path}/5.9.2/Qt3DQuick/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuickAnimation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickAnimation
    command += $${header_path}/5.9.2/Qt3DQuickAnimation/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuickExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickExtras
    command += $${header_path}/5.9.2/Qt3DQuickExtras/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuickInput)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickInput
    command += $${header_path}/5.9.2/Qt3DQuickInput/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuickRender)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickRender
    command += $${header_path}/5.9.2/Qt3DQuickRender/private
    header_path=$$get_add_include_bundle(Qt, Qt3DQuickScene2D)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickScene2D
    command += $${header_path}/5.9.2/Qt3DQuickScene2D/private
    header_path=$$get_add_include_bundle(Qt, Qt3DRender)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DRender
    command += $${header_path}/5.9.2/Qt3DRender/private
    header_path=$$get_add_include_bundle(Qt, QtAccessibilitySupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtAccessibilitySupport
    command += $${header_path}/5.9.2/QtAccessibilitySupport/private
    header_path=$$get_add_include_bundle(Qt, QtAndroidExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtAndroidExtras
    command += $${header_path}/5.9.2/QtAndroidExtras/private
    header_path=$$get_add_include_bundle(Qt, QtBluetooth)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtBluetooth
    command += $${header_path}/5.9.2/QtBluetooth/private
    header_path=$$get_add_include_bundle(Qt, QtCharts)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtCharts
    command += $${header_path}/5.9.2/QtCharts/private
    header_path=$$get_add_include_bundle(Qt, QtConcurrent)
    command += $${header_path}
    header_path=$$get_add_include_bundle(Qt, QtCore)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtCore
    command += $${header_path}/5.9.2/QtCore/private
    header_path=$$get_add_include_bundle(Qt, QtDataVisualization)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtDataVisualization
    command += $${header_path}/5.9.2/QtDataVisualization/private
    header_path=$$get_add_include_bundle(Qt, QtDeviceDiscoverySupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtDeviceDiscoverySupport
    command += $${header_path}/5.9.2/QtDeviceDiscoverySupport/private
    header_path=$$get_add_include_bundle(Qt, QtEglSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtEglSupport
    command += $${header_path}/5.9.2/QtEglSupport/private
    header_path=$$get_add_include_bundle(Qt, QtEventDispatcherSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtEventDispatcherSupport
    command += $${header_path}/5.9.2/QtEventDispatcherSupport/private
    header_path=$$get_add_include_bundle(Qt, QtFbSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtFbSupport
    command += $${header_path}/5.9.2/QtFbSupport/private
    header_path=$$get_add_include_bundle(Qt, QtFontDatabaseSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtFontDatabaseSupport
    command += $${header_path}/5.9.2/QtFontDatabaseSupport/private
    header_path=$$get_add_include_bundle(Qt, QtGamepad)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtGamepad
    command += $${header_path}/5.9.2/QtGamepad/private
    header_path=$$get_add_include_bundle(Qt, QtGui)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtGui
    command += $${header_path}/5.9.2/QtGui/private
    command += $${header_path}/5.9.2/QtGui/qpa
    header_path=$$get_add_include_bundle(Qt, QtHelp)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtHelp
    command += $${header_path}/5.9.2/QtHelp/private
    header_path=$$get_add_include_bundle(Qt, QtInputSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtInputSupport
    command += $${header_path}/5.9.2/QtInputSupport/private
    header_path=$$get_add_include_bundle(Qt, QtLocation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtLocation
    command += $${header_path}/5.9.2/QtLocation/private
    header_path=$$get_add_include_bundle(Qt, QtMultimedia)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimedia
    command += $${header_path}/5.9.2/QtMultimedia/private
    header_path=$$get_add_include_bundle(Qt, QtMultimediaQuick_p)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimediaQuick_p
    command += $${header_path}/5.9.2/QtMultimediaQuick_p/private
    header_path=$$get_add_include_bundle(Qt, QtMultimediaWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimediaWidgets
    command += $${header_path}/5.9.2/QtMultimediaWidgets/private
    header_path=$$get_add_include_bundle(Qt, QtNetwork)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNetwork
    command += $${header_path}/5.9.2/QtNetwork/private
    header_path=$$get_add_include_bundle(Qt, QtNetworkAuth)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNetworkAuth
    command += $${header_path}/5.9.2/QtNetworkAuth/private
    header_path=$$get_add_include_bundle(Qt, QtNfc)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNfc
    command += $${header_path}/5.9.2/QtNfc/private
    header_path=$$get_add_include_bundle(Qt, QtOpenGL)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtOpenGL
    command += $${header_path}/5.9.2/QtOpenGL/private
    header_path=$$get_add_include_bundle(Qt, QtOpenGLExtensions)
    command += $${header_path}
    header_path=$$get_add_include_bundle(Qt, QtPacketProtocol)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPacketProtocol
    command += $${header_path}/5.9.2/QtPacketProtocol/private
    header_path=$$get_add_include_bundle(Qt, QtPlatformCompositorSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPlatformCompositorSupport
    command += $${header_path}/5.9.2/QtPlatformCompositorSupport/private
    header_path=$$get_add_include_bundle(Qt, QtPlatformHeaders)
    command += $${header_path}
    header_path=$$get_add_include_bundle(Qt, QtPositioning)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPositioning
    command += $${header_path}/5.9.2/QtPositioning/private
    header_path=$$get_add_include_bundle(Qt, QtPrintSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPrintSupport
    command += $${header_path}/5.9.2/QtPrintSupport/private
    command += $${header_path}/5.9.2/QtPrintSupport/qpa
    header_path=$$get_add_include_bundle(Qt, QtPurchasing)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPurchasing
    command += $${header_path}/5.9.2/QtPurchasing/private
    header_path=$$get_add_include_bundle(Qt, QtQml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQml
    command += $${header_path}/5.9.2/QtQml/private
    header_path=$$get_add_include_bundle(Qt, QtQmlDebug)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQmlDebug
    command += $${header_path}/5.9.2/QtQmlDebug/private
    header_path=$$get_add_include_bundle(Qt, QtQuick)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuick
    command += $${header_path}/5.9.2/QtQuick/private
    header_path=$$get_add_include_bundle(Qt, QtQuickControls2)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickControls2
    command += $${header_path}/5.9.2/QtQuickControls2/private
    header_path=$$get_add_include_bundle(Qt, QtQuickParticles)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickParticles
    command += $${header_path}/5.9.2/QtQuickParticles/private
    header_path=$$get_add_include_bundle(Qt, QtQuickTemplates2)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickTemplates2
    command += $${header_path}/5.9.2/QtQuickTemplates2/private
    header_path=$$get_add_include_bundle(Qt, QtQuickTest)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickTest
    command += $${header_path}/5.9.2/QtQuickTest/private
    header_path=$$get_add_include_bundle(Qt, QtQuickWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickWidgets
    command += $${header_path}/5.9.2/QtQuickWidgets/private
    header_path=$$get_add_include_bundle(Qt, QtRemoteObjects)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtRemoteObjects
    command += $${header_path}/5.9.2/QtRemoteObjects/private
    header_path=$$get_add_include_bundle(Qt, QtRepParser)
    command += $${header_path}
    header_path=$$get_add_include_bundle(Qt, QtScript)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScript
    command += $${header_path}/5.9.2/QtScript/private
    header_path=$$get_add_include_bundle(Qt, QtScriptTools)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScriptTools
    command += $${header_path}/5.9.2/QtScriptTools/private
    header_path=$$get_add_include_bundle(Qt, QtScxml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScxml
    command += $${header_path}/5.9.2/QtScxml/private
    header_path=$$get_add_include_bundle(Qt, QtSensors)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSensors
    command += $${header_path}/5.9.2/QtSensors/private
    header_path=$$get_add_include_bundle(Qt, QtSerialBus)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSerialBus
    command += $${header_path}/5.9.2/QtSerialBus/private
    header_path=$$get_add_include_bundle(Qt, QtSerialPort)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSerialPort
    command += $${header_path}/5.9.2/QtSerialPort/private
    header_path=$$get_add_include_bundle(Qt, QtServiceSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtServiceSupport
    command += $${header_path}/5.9.2/QtServiceSupport/private
    header_path=$$get_add_include_bundle(Qt, QtSql)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSql
    command += $${header_path}/5.9.2/QtSql/private
    header_path=$$get_add_include_bundle(Qt, QtSvg)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSvg
    command += $${header_path}/5.9.2/QtSvg/private
    header_path=$$get_add_include_bundle(Qt, QtTest)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtTest
    command += $${header_path}/5.9.2/QtTest/private
    header_path=$$get_add_include_bundle(Qt, QtTextToSpeech)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtTextToSpeech
    command += $${header_path}/5.9.2/QtTextToSpeech/private
    header_path=$$get_add_include_bundle(Qt, QtThemeSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtThemeSupport
    command += $${header_path}/5.9.2/QtThemeSupport/private
    header_path=$$get_add_include_bundle(Qt, QtUiPlugin)
    command += $${header_path}
    header_path=$$get_add_include_bundle(Qt, QtUiTools)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtUiTools
    command += $${header_path}/5.9.2/QtUiTools/private
    header_path=$$get_add_include_bundle(Qt, QtWebChannel)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebChannel
    command += $${header_path}/5.9.2/QtWebChannel/private
    header_path=$$get_add_include_bundle(Qt, QtWebSockets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebSockets
    command += $${header_path}/5.9.2/QtWebSockets/private
    header_path=$$get_add_include_bundle(Qt, QtWebView)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebView
    command += $${header_path}/5.9.2/QtWebView/private
    header_path=$$get_add_include_bundle(Qt, QtWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWidgets
    command += $${header_path}/5.9.2/QtWidgets/private
    header_path=$$get_add_include_bundle(Qt, QtXml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtXml
    command += $${header_path}/5.9.2/QtXml/private
    header_path=$$get_add_include_bundle(Qt, QtXmlPatterns)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtXmlPatterns
    command += $${header_path}/5.9.2/QtXmlPatterns/private
    header_path=$$get_add_include_bundle(Qt, QtZlib)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Qt){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

#修改
defineTest(add_library_Qt){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(Qt, Qt)
    add_library(Qt, Qt5AccessibilitySupport)
    add_library(Qt, Qt5Bootstrap)
    add_library(Qt, Qt5DeviceDiscoverySupport)
    add_library(Qt, Qt5EglSupport)
    add_library(Qt, Qt5EventDispatcherSupport)
    add_library(Qt, Qt5FbSupport)
    add_library(Qt, Qt5FontDatabaseSupport)
    add_library(Qt, Qt5InputSupport)
    add_library(Qt, Qt5OpenGLExtensions)
    add_library(Qt, Qt5PacketProtocol)
    add_library(Qt, Qt5PlatformCompositorSupport)
    add_library(Qt, Qt5QmlDebug)
    add_library(Qt, Qt5QmlDevTools)
    add_library(Qt, Qt5ServiceSupport)
    add_library(Qt, Qt5ThemeSupport)
    add_library(Qt, Qt5UiTools)
    add_library(Qt, qtfreetype)
    add_library(Qt, qtlibpng)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_Qt) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_library(Qt, Qt)
    #add_deploy_libraryes(Qt)
    add_deploy_library(Qt, Qt5AccessibilitySupport)
    add_deploy_library(Qt, Qt5Bootstrap)
    add_deploy_library(Qt, Qt5DeviceDiscoverySupport)
    add_deploy_library(Qt, Qt5EglSupport)
    add_deploy_library(Qt, Qt5EventDispatcherSupport)
    add_deploy_library(Qt, Qt5FbSupport)
    add_deploy_library(Qt, Qt5FontDatabaseSupport)
    add_deploy_library(Qt, Qt5InputSupport)
    add_deploy_library(Qt, Qt5OpenGLExtensions)
    add_deploy_library(Qt, Qt5PacketProtocol)
    add_deploy_library(Qt, Qt5PlatformCompositorSupport)
    add_deploy_library(Qt, Qt5QmlDebug)
    add_deploy_library(Qt, Qt5QmlDevTools)
    add_deploy_library(Qt, Qt5ServiceSupport)
    add_deploy_library(Qt, Qt5ThemeSupport)
    add_deploy_library(Qt, Qt5UiTools)
    add_deploy_library(Qt, qtfreetype)
    add_deploy_library(Qt, qtlibpng)

    return (1)
}
