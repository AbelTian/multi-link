TEMPLATE = app
CONFIG += console c++11
CONFIG += app_bundle
CONFIG -= qt

SOURCES += main.cpp

include (../../multi-link/add_base_manager.pri)
add_deploy()
