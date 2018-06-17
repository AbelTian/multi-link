#----------------------------------------------------------------
#add_library_Qt.pri
#���Ǹ��û��ṩ�ķ���pri
#����Ƚ�common�����������û������и��ġ�
#----------------------------------------------------------------
#_bundle��ȡ�ᣬ����macOSϵͳ�£�ʹ�õ�libraryΪbundle��ʽ������dylib��ʽ��

#######################################################################################
#��ʼ������
#######################################################################################


#######################################################################################
#���庯��
#######################################################################################
#�޸�
defineTest(add_include_Qt){
    #��Ϊ�գ��϶���Դ�����·���� ���ڵ���ͷ�ļ�
    header_path = $$1
    #�������1Ϊ�գ���ô����SDK���·�� ��������ʱ����ͷ�ļ�
    #�˴�_bundle���� mac��ͷ�ļ���bundle� ����
    isEmpty(header_path)header_path=$$get_add_include(Qt, Qt)

    command =
    #basic
    command += $${header_path}
    #�������$${path}�µ����ļ���
    #...
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DAnimation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DAnimation
    command += $${header_path}/5.9.2/Qt3DAnimation/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DCore)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DCore
    command += $${header_path}/5.9.2/Qt3DCore/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DExtras
    command += $${header_path}/5.9.2/Qt3DExtras/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DInput)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DInput
    command += $${header_path}/5.9.2/Qt3DInput/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DLogic)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DLogic
    command += $${header_path}/5.9.2/Qt3DLogic/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuick)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuick
    command += $${header_path}/5.9.2/Qt3DQuick/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuickAnimation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickAnimation
    command += $${header_path}/5.9.2/Qt3DQuickAnimation/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuickExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickExtras
    command += $${header_path}/5.9.2/Qt3DQuickExtras/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuickInput)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickInput
    command += $${header_path}/5.9.2/Qt3DQuickInput/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuickRender)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickRender
    command += $${header_path}/5.9.2/Qt3DQuickRender/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DQuickScene2D)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DQuickScene2D
    command += $${header_path}/5.9.2/Qt3DQuickScene2D/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, Qt3DRender)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/Qt3DRender
    command += $${header_path}/5.9.2/Qt3DRender/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtAccessibilitySupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtAccessibilitySupport
    command += $${header_path}/5.9.2/QtAccessibilitySupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtAndroidExtras)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtAndroidExtras
    command += $${header_path}/5.9.2/QtAndroidExtras/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtBluetooth)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtBluetooth
    command += $${header_path}/5.9.2/QtBluetooth/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtCharts)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtCharts
    command += $${header_path}/5.9.2/QtCharts/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtConcurrent)
    command += $${header_path}
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtCore)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtCore
    command += $${header_path}/5.9.2/QtCore/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtDataVisualization)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtDataVisualization
    command += $${header_path}/5.9.2/QtDataVisualization/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtDeviceDiscoverySupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtDeviceDiscoverySupport
    command += $${header_path}/5.9.2/QtDeviceDiscoverySupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtEglSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtEglSupport
    command += $${header_path}/5.9.2/QtEglSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtEventDispatcherSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtEventDispatcherSupport
    command += $${header_path}/5.9.2/QtEventDispatcherSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtFbSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtFbSupport
    command += $${header_path}/5.9.2/QtFbSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtFontDatabaseSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtFontDatabaseSupport
    command += $${header_path}/5.9.2/QtFontDatabaseSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtGamepad)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtGamepad
    command += $${header_path}/5.9.2/QtGamepad/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtGui)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtGui
    command += $${header_path}/5.9.2/QtGui/private
    command += $${header_path}/5.9.2/QtGui/qpa
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtHelp)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtHelp
    command += $${header_path}/5.9.2/QtHelp/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtInputSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtInputSupport
    command += $${header_path}/5.9.2/QtInputSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtLocation)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtLocation
    command += $${header_path}/5.9.2/QtLocation/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtMultimedia)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimedia
    command += $${header_path}/5.9.2/QtMultimedia/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtMultimediaQuick_p)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimediaQuick_p
    command += $${header_path}/5.9.2/QtMultimediaQuick_p/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtMultimediaWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtMultimediaWidgets
    command += $${header_path}/5.9.2/QtMultimediaWidgets/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtNetwork)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNetwork
    command += $${header_path}/5.9.2/QtNetwork/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtNetworkAuth)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNetworkAuth
    command += $${header_path}/5.9.2/QtNetworkAuth/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtNfc)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtNfc
    command += $${header_path}/5.9.2/QtNfc/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtOpenGL)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtOpenGL
    command += $${header_path}/5.9.2/QtOpenGL/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtOpenGLExtensions)
    command += $${header_path}
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPacketProtocol)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPacketProtocol
    command += $${header_path}/5.9.2/QtPacketProtocol/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPlatformCompositorSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPlatformCompositorSupport
    command += $${header_path}/5.9.2/QtPlatformCompositorSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPlatformHeaders)
    command += $${header_path}
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPositioning)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPositioning
    command += $${header_path}/5.9.2/QtPositioning/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPrintSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPrintSupport
    command += $${header_path}/5.9.2/QtPrintSupport/private
    command += $${header_path}/5.9.2/QtPrintSupport/qpa
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtPurchasing)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtPurchasing
    command += $${header_path}/5.9.2/QtPurchasing/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQml
    command += $${header_path}/5.9.2/QtQml/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQmlDebug)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQmlDebug
    command += $${header_path}/5.9.2/QtQmlDebug/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuick)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuick
    command += $${header_path}/5.9.2/QtQuick/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuickControls2)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickControls2
    command += $${header_path}/5.9.2/QtQuickControls2/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuickParticles)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickParticles
    command += $${header_path}/5.9.2/QtQuickParticles/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuickTemplates2)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickTemplates2
    command += $${header_path}/5.9.2/QtQuickTemplates2/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuickTest)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickTest
    command += $${header_path}/5.9.2/QtQuickTest/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtQuickWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtQuickWidgets
    command += $${header_path}/5.9.2/QtQuickWidgets/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtRemoteObjects)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtRemoteObjects
    command += $${header_path}/5.9.2/QtRemoteObjects/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtRepParser)
    command += $${header_path}
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtScript)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScript
    command += $${header_path}/5.9.2/QtScript/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtScriptTools)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScriptTools
    command += $${header_path}/5.9.2/QtScriptTools/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtScxml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtScxml
    command += $${header_path}/5.9.2/QtScxml/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtSensors)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSensors
    command += $${header_path}/5.9.2/QtSensors/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtSerialBus)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSerialBus
    command += $${header_path}/5.9.2/QtSerialBus/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtSerialPort)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSerialPort
    command += $${header_path}/5.9.2/QtSerialPort/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtServiceSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtServiceSupport
    command += $${header_path}/5.9.2/QtServiceSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtSql)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSql
    command += $${header_path}/5.9.2/QtSql/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtSvg)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtSvg
    command += $${header_path}/5.9.2/QtSvg/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtTest)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtTest
    command += $${header_path}/5.9.2/QtTest/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtTextToSpeech)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtTextToSpeech
    command += $${header_path}/5.9.2/QtTextToSpeech/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtThemeSupport)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtThemeSupport
    command += $${header_path}/5.9.2/QtThemeSupport/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtUiPlugin)
    command += $${header_path}
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtUiTools)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtUiTools
    command += $${header_path}/5.9.2/QtUiTools/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtWebChannel)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebChannel
    command += $${header_path}/5.9.2/QtWebChannel/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtWebSockets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebSockets
    command += $${header_path}/5.9.2/QtWebSockets/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtWebView)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWebView
    command += $${header_path}/5.9.2/QtWebView/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtWidgets)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtWidgets
    command += $${header_path}/5.9.2/QtWidgets/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtXml)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtXml
    command += $${header_path}/5.9.2/QtXml/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtXmlPatterns)
    command += $${header_path}
    command += $${header_path}/5.9.2
    command += $${header_path}/5.9.2/QtXmlPatterns
    command += $${header_path}/5.9.2/QtXmlPatterns/private
    isEmpty(header_path)header_path=$$get_add_include_bundle(Qt, QtZlib)
    command += $${header_path}

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#�޸�
defineTest(add_defines_Qt){
    #������SDK���defines
    #add_defines()

    return (1)
}

#�޸�
defineTest(add_library_Qt){
    #����ط�add_library_bundle���� macOS�£�lib��bundle� ����
    #������SDK���library
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


#��������library
#ע��AndroidҲ��Ҫ���������ʹ���������Android�Żᷢ��Library������ʱ���ϱߵ�ֻ���������á�
#�޸�
defineTest(add_deploy_library_Qt) {
    #����ط�add_deploy_library_bundle����macOS�·�������bundle��ʽ��
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