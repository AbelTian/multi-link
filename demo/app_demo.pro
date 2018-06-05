TARGET = Proj1
TEMPLATE = app

HEADERS += 
SOURCES += 

include (multi-link/add_base_manager.pri)
add_deploy()
add_version()
add_language(...)
add_deploy_config(...)

add_dependent_manager(QQt)
add_custom_dependent_manager(LibDemo)