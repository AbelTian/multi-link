#------------------------------------------------------------------------------------------------
##add_plugin.pri

##install to SDK plugin path
##把Library按照SDK plugin格式安装到LIB_SDK_ROOT
##发布到plugin是为Multi Link提供的安装脚本准备的。
##安装到Qt Creator，注意Qt Creator是使用什么编译的，即编译目标，需要对应。
##安装到独立的Qt Designer，自行、只需，将plugin.dll拷贝到Qt SDK目录下即可。注意下Qt SDK Version 和 SDK的编译目标，都需要对应。
##Multi-link对以上工作，在LIB_SDK_ROOT/SYS_STD_ROOT/下提供脚本。

##依赖add_version.pri里设置的version。
##依赖add_platform.pri里的QSYS变量和路径
##依赖add_multi_link_technology.pri里面的三大路径
##依赖add_function.pri

##please don't modify this pri
#------------------------------------------------------------------------------------------------

##SDK plugin格式
##LibGroupName/Windows/include/libName/***.h [empty]
##                    /bin/libName<ver>[d].dll
##                    /lib/libName<ver>[d].a .lib
##                    /libexec/Qt5Widgets.dll Qt5Network.dll ...

##LibGroupName/Linux/include/libName/***.h [empty]
##                  /bin/
##                  /lib/libName.so.*
##                  /libexec/libQt5Widgets.so libQt5Network.so ...

##LibGroupName/macOS/include/libName/***.h [empty]
##                  /bin/
##                  /lib/libName<ver>.dylib
##                      /libName[_debug].dylib
##                  /libexec/Qt5Widgets.framework Qt5Network.framework ...

#固定SDK结构，操作系统中直接使用这个目录结构。
#没有SDK SubDir结构！

#这个功能暂时不添加，用户手动处理。

#把plugin.dll拷贝到Qt Creater/bin/plugins/desinger里，
#windeployqt发布下plugin.dll，把发布文件拷贝到Qt Creater/bin里，
#Qt Creator里的ui编辑器（即集成的ui设计器）里便可以使用。注意编译目标 和 Qt版本 对应好。

#把plugin.dll拷贝到Qt SDK/plugins/designer里，
#Qt SDK里的独立的Qt Designer便可以使用。注意编译目标 和 Qt版本 对应好。
