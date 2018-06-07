TARGET = Proj1
TEMPLATE = lib

HEADERS += 
SOURCES += 

include (../multi-link/add_base_manager.pri)
add_project_name(Proj1)
add_source_dir($$PWD)
add_build_dir($$DESTDIR)

add_version()
add_sdk()

add_dependent_manager(QQt)
