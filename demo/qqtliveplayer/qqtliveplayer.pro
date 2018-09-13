#-------------------------------------------------
#
# Project created by QtCreator 2016-06-17T10:03:52
#
#-------------------------------------------------
QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qqtliveplayer
TEMPLATE = app

INCLUDEPATH +=  .

CONFIG += c++11

SOURCES += $$PWD/main.cpp $$PWD/qqtapp.cpp $$PWD/qqtwindow.cpp \
    animationmanager.cpp \
    mainwindow.cpp

HEADERS  += $$PWD/qqtapp.h $$PWD/qqtwindow.h \
    animationmanager.h \
    mainwindow.h


FORMS    += $$PWD/qqtwindow.ui \
    mainwindow.ui


############################################
#添加所有提供函数的pri 很有美感
############################################
include(../../multi-link/add_base_manager.pri)
system(touch main.cpp)
############################################
#对产品线的控制结构Multi-link下命令 开启产品线
############################################
#这个的设置有特点，要先设置
add_version (1,0,0,0)

#先发布App
#app从build室到deploy
add_deploy()

#后发布依赖
#libQQt从sdk仓到deploy(+到build室，用户调试需要。)
add_dependent_manager(QQt)
#添加其他library
#libVLCQt从sdk仓到deploy(+到build室，用户调试需要。)
add_dependent_manager(VLC)

#给程序增加一种语言（自动增加zh_CN语言(.ts)，用户打开生成的ts文件翻译，自动发布zh_CN语言(.qm)。）
add_language($$PWD/qqtliveplayer.pro, $$PWD/AppRoot/lang, zh_CN)
#程序有配置文件，在AppRoot里，自动发布到产品库里去。
add_deploy_config($$PWD/AppRoot)
#给程序增加一个图标 （看test/工程）
#add_icons()

#... extra
DISTFILES += AppRoot/lang/zh_CN.ts
