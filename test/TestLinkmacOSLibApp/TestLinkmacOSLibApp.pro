#-------------------------------------------------
#
# Project created by QtCreator 2018-10-06T08:16:10
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = TestLinkmacOSLibApp
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        mainwindow.cpp

HEADERS += \
        mainwindow.h

FORMS += \
        mainwindow.ui

include($${PWD}/../../multi-link/add_base_manager.pri)

#-------------------------------------------------
#用户工程配置
#-------------------------------------------------
add_version(1,0,0,0)
add_deploy()
add_deploy_config($${PWD}/AppRoot)
add_dependent_manager(QQt)

#add_custom_static_dependent_manager(LinkStaticLibTest)
add_custom_dependent_manager(LinkStaticLibTest2)
#add_custom_dependent_manager(LinkStaticLibTest3)

#此处注意，6号静态库，依赖了2号动态库，用户必须依赖2号库来启动发布拷贝2号的过程，否则，运行时6号找不到2号，运行失败。
#而且，由于6号是静态库，App报错的时候，不会报6号依赖2号，而是报app依赖2号，奇葩的，需要注意。
add_custom_dependent_manager(AddDynamicLibTest2)
add_custom_dependent_manager(LinkDynamicLibTest6)

system(touch main.cpp)

#-------------------------------------------------
#用户工程配置
#-------------------------------------------------
equals(QSYS_PRIVATE, macOS) {
    CONFIG += app_bundle
}

contains(QSYS_PRIVATE, Android|AndroidX86) {
    CONFIG += mobility
    MOBILITY =
    DISTFILES += \
        android/AndroidManifest.xml

    ANDROID_PACKAGE_SOURCE_DIR = $${PWD}/android
}

message ($${TARGET} config $${CONFIG})
message ($${TARGET} DEFINE $${DEFINES})
message ($${TARGET} prelink $${QMAKE_PRE_LINK})
message ($${TARGET} postlink $${QMAKE_POST_LINK})
