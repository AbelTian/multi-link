#-----------------------------------------------------------------------------
#add_platform.pri
#这个pri决定编译目标平台

#依赖 无
#-----------------------------------------------------------------------------
#注释：在这里系统的支持平台的类型
#注释：放弃使用mkspecs。
#使用方法：在工程编译配置页面配置环境变量QSYS，从以下选，linkSDK也从这个值的文件夹里link，发布App也发布到这个值的文件夹下，跟随app发布的sdk也从这个值文件夹下拷贝，强大吧。Multi-link把基于Qt开发的程序全部自动化从build发布到产品库和链接库(SDK仓)，一切从build室开始。

#从环境变量读取QSYS保存为qmake变量QSYS_PRIVATE
QSYS_PRIVATE = $$(QSYS)
#由于主流开发目标为一种操作系统配一种硬件指令集架构系统，一配一的模式，所以我把操作系统和CPU指令集，糅合在一种变量里，名称为QSYS。
#e-linux linux
contains(QSYS_PRIVATE, Embedded) {
    #embedded common macro
    DEFINES += __EMBEDDED_LINUX__
} else:contains(QSYS_PRIVATE, Arm32) {
    DEFINES += __EMBEDDED_LINUX__
    #arm32 private
    DEFINES += __ARM_LINUX__
} else:contains(QSYS_PRIVATE, Armhf32) {
    DEFINES += __EMBEDDED_LINUX__
    #arm32 private
    DEFINES += __ARM_LINUX__
    #armhf32 private
    DEFINES += __ARMHF_LINUX__
} else:contains(QSYS_PRIVATE, Mips32) {
    DEFINES += __EMBEDDED_LINUX__
    #mips32 private
    DEFINES += __MIPS_LINUX__
} else:contains(QSYS_PRIVATE, Linux) {
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
} else:contains(QSYS_PRIVATE, Linux64) {
    DEFINES += __LINUX__
    DEFINES += __LINUX64__

#windows msvc
} else:contains(QSYS_PRIVATE, Win32|Windows) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
} else:contains(QSYS_PRIVATE, Win64) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
} else:contains(QSYS_PRIVATE, WinRT) {
    DEFINES += __WIN__
    DEFINES += __WINRT__
} else:contains(QSYS_PRIVATE, MSVC32|MSVC) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
    DEFINES += __MSVC__
    DEFINES += __MSVC32__
} else:contains(QSYS_PRIVATE, MSVC64) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
    DEFINES += __MSVC__
    DEFINES += __MSVC64__

#ios mac
} else:contains(QSYS_PRIVATE, macOS) {
    DEFINES += __DARWIN__
} else:contains(QSYS_PRIVATE, iOS) {
    DEFINES += __IOS__
} else:contains(QSYS_PRIVATE, iOSSimulator) {
    DEFINES += __IOS__
    #TODO:no qcustomplot word printer process

#android
} else:contains(QSYS_PRIVATE, Android) {
    #Android系统对应主要CPU指令集架构为armeabi-v7a
    DEFINES += __ANDROID__
} else:contains(QSYS_PRIVATE, AndroidX86) {
    DEFINES += __ANDROID__
    DEFINES += __ANDROIDX86__
}

defineReplace(get_base_name){
    isEmpty(1):error("get_base_name(absolute_file_path) need one argument.")
    absolute_file_path = $$1
    absolute_file_path ~= s,\\,/,g
    file_path = $$absolute_file_path
    file_path ~= s:/[^/]*$::p
    base_name = $$replace(absolute_file_path, $$file_path/, "")
    return ($${base_name})
}

defineReplace(get_file_path){
    isEmpty(1):error("get_file_path(absolute_file_path) need one argument.")
    file_path = $$1
    file_path ~= s:/[^/]*$::p
    return ($${file_path})
}

#QMAKESPEC_NAME = $$[QT_INSTALL_PREFIX]
#QSPEC = $$get_base_name($${QMAKESPEC_NAME})
#message($$TARGET use Qt version $${QSPEC})
#message($$TARGET use spec $$[QMAKE_XSPEC])

#message ($$[QT_INSTALL_PREFIX])
#message ($$dirname($$[QT_INSTALL_PREFIX]))
#QMAKESPEC_NAME = $${QMAKESPEC}
#QMAKESPEC_NAME ~= s@^/.*/([^/]+)/?@\1@g
#QMAKESPECS = $${QMAKESPEC}
#QMAKESPECS ~= s:/[^/]*$::p
#message ($${QMAKESPEC_NAME})
#message ($${QMAKESPECS})

#注意：Multi-link对于CONFIG+=build_all是在默认编译路径下同时编译两种lib，Debug和Release文件夹下，qmake默认就是这么做的，Multi-link也会这么做，请注意。
BUILD=
CONFIG(debug, debug|profile|release):BUILD=Debug
CONFIG(release, debug|profile|release):BUILD=Release
CONFIG(profile, debug|profile|release):BUILD=Profile

#在新的改进里，准备废弃这个路径。至少和编译路径脱开关系。
#编译和这个路径已经脱开关系了。也就是说，用户不设置Qt Creator的默认编译路径，也可以使用Multi-link技术。就是用默认的好了，或者使用Multi-link 1.0的路径。
#过去曾经思考使用的路径。
QSYS_STD_DIR = $${QSYS_PRIVATE}/$${QT_VERSION}/$${BUILD}
QSYS_STD_DIR = $${QSYS_PRIVATE}/$${QT_VERSION}
#SDK生产、链接使用这个路径。SDK debug版和release版放在一起，当自动发布全部library的时候，无法分辨调试版和非调试版。
QSYS_STD_DIR = $${QSYS_PRIVATE}
#App生产使用这个路径。App的debug版和release版合在一个文件夹里是不合理的。
QAPP_STD_DIR = $${QSYS_PRIVATE}

message(add_platform.pri)
message(Build $${TARGET} to $${QSYS_PRIVATE} \(QSYS=$${QSYS_PRIVATE} is configed in project build page.\) )
message(Build $${TARGET} at $${QSYS_STD_DIR} \(Qt Kit page FileSystem Name=$${QSYS_PRIVATE}"," optionaled\) )
message(Build $${TARGET} on $${QMAKE_HOST.os} \(Operating System=$${QMAKE_HOST.os}\) )
message(Build $${TARGET} in $${OUT_PWD})
isEmpty(QSYS_PRIVATE) : message(Build $${TARGET} Qt Kit page FileSystem Name \(optionaled\) is decided by env variable QSYS. Please set it. )

isEmpty(QSYS_PRIVATE) {
    message(env variable QSYS is required! pleace check add_platform.pri)
    error(error occured! please check build output panel.)
}

isEmpty(QSYS_PRIVATE) {
    message(1. I suggest you change creator default build directory!)
    message(2. env variable QSYS is required!)
    message(pleace check add_platform.pri)
    error("error occured, please check build output panel.")
}


#in theory, this should not be limited to 4.8.0, no limit is good.
#c++ 11是可选的，有example用。
lessThan(QT_VERSION, 4.8.0) {
    message(A. ensure your compiler support c++11 feature)
    message(B. suggest Qt version >= 4.8.0)
    #error(  error occured!)
}

#把这两个变量传递给源代码。
DEFINES += Q_SYS_NAME=$${QSYS_PRIVATE}
DEFINES += Q_BUILD_TYPE=$${BUILD}
