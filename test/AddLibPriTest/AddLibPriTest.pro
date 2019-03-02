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
message($$QMAKE_TARGET_COPYRIGHT)

#test link workflow...

#这些library，有SDK就能编译通过。
#CONFIG += link_some_libraries
contains(CONFIG, link_some_libraries) {
    add_dependent_manager(armadillo)
    add_dependent_manager(Boost)
    add_dependent_manager(chipmunk)
    add_dependent_manager(Clipper)
    add_dependent_manager(crypto++)
    add_dependent_manager(curl)
    add_dependent_manager(dlib)
    add_dependent_manager(FFmpeg2)
    add_dependent_manager(FFmpeg3)
    add_dependent_manager(FFmpeg4)
    add_dependent_manager(FLTK)
    add_dependent_manager(FMOD)
    add_dependent_manager(fox)
    add_dependent_manager(freetype2)
    add_dependent_manager(GLFW)
    add_dependent_manager(GoogleTest)
    add_dependent_manager(leveldb)
    add_dependent_manager(libpng)
    add_dependent_manager(libiconv)
    add_dependent_manager(libevent)
    add_dependent_manager(libuv)
    add_dependent_manager(log4cpp)
    add_dependent_manager(Log4Qt)
    add_dependent_manager(loki)
    add_dependent_manager(lua)
    add_dependent_manager(ode013)
    add_dependent_manager(OGRE)
    add_dependent_manager(OpenCV)
    add_dependent_manager(OpenSceneGraph)
    add_dependent_manager(Python)
    add_dependent_manager(Python36)
    add_dependent_manager(QQt)
    add_dependent_manager(QQtExquisite)
    add_dependent_manager(Qwt)
    add_dependent_manager(QwtPlot3d)
    add_dependent_manager(SDL)
    add_dependent_manager(SDL2)
    add_dependent_manager(Sequence)
    add_dependent_manager(simbody)
    add_dependent_manager(ta-lib)
    add_dependent_manager(VLCQt)
    add_dependent_manager(VTK630)
    add_dependent_manager(QuaZip)
    add_dependent_manager(zlib)
    add_dependent_manager(libpng)
    add_dependent_manager(tinyxml2)
    add_dependent_manager(protobuf)
    add_dependent_manager(libmad)
    add_dependent_manager(libmp3lame)
    add_dependent_manager(libspeex)
    add_dependent_manager(Template)
    add_dependent_manager(libqwav)
}

message(...... $$DEFINES)
message(...... $$QT_VERSION)
