#-------------------------------------------------
#
# Project created by QtCreator 2018-06-15T22:58:40
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = AddLibPriTest
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

include(../../multi-link/add_base_manager.pri)
add_version(1,0,0,0)
add_deploy()

#test link workflow...
#add_create_dependent_manager(lua)
#add_create_dependent_manager(Sequence)
#add_create_dependent_manager(leveldb)
#add_create_dependent_manager(tolua)
#add_create_dependent_manager(Python)
message($$QMAKE_TARGET_COPYRIGHT)
add_create_dependent_manager(libuv)
