TARGET = Proj1
TEMPLATE = app

HEADERS += 
SOURCES += 

include (../multi-link/add_base_manager.pri)
add_deploy()
add_version()
add_language(...)
add_deploy_config(...)

add_dependent_manager(QQtBase)
add_custom_dependent_manager(LibDemo)
add_dependent_manager(Template)
add_dependent_manager(SDL2)
add_dependent_manager(FFmpeg3.2)
add_dependent_manager(FFmpeg4.0)
add_dependent_manager(FMOD)
add_dependent_manager(GoogleTest)
add_dependent_manager(log4cpp)
add_dependent_manager(OpenCV)
add_dependent_manager(OpenSceneGraph)
add_dependent_manager(Qwt)
add_dependent_manager(QwtPlot3d)
add_dependent_manager(VLC)
