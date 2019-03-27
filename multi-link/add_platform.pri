#-----------------------------------------------------------------------------
#add_platform.pri
#这个pri决定编译目标平台

#依赖 无

#please don't modify this pri
#-----------------------------------------------------------------------------
#注释：在这里系统的支持平台的类型
#注释：放弃使用mkspecs。
#使用：在工程编译配置页面配置环境变量QSYS，从以下选，linkSDK也从这个值的文件夹里link，发布App也发布到这个值的文件夹下，跟随app发布的sdk也从这个值文件夹下拷贝，强大吧。Multi-link把基于Qt开发的程序全部自动化从build发布到产品库和链接库(SDK仓)，一切从build室开始。

#从环境变量读取QSYS保存为qmake变量QSYS_PRIVATE
QSYS_PRIVATE = $$(QSYS)
#由于主流开发目标为一种操作系统配一种硬件指令集架构系统，一配一的模式，所以我把操作系统和CPU指令集，糅合在一种变量里，名称为QSYS。

#注释：如果使用CONFIG里的平台配置来区分QSYS呢？到达这个文件的时候CONFIG平台配置已经有了。所以，试试。
#现在，假设用户没有设置QSYS，我期望用户不设置QSYS，Multi-link就能正常分辨平台。
#探测的主要内容：平台名称 位数
#写个位宽检测程序呢？$$system()一下？那是不可能的，编译不过。
#结论，等吧，等Qt Creator升级，输出SysName给qmake了，就可以使用了。

#debug ...
#isEmpty(QSYS_PRIVATE):message(Multi-link detect platform automatically.)
#message(mkspec: $$[QMAKE_SPEC])
#message(xmkspec: $$[QMAKE_XSPEC])
#message(Qt install prefix: $$[QT_INSTALL_PREFIX])
#message(qmake mkspec: $${QMAKESPEC})
#message(compiler: $${QMAKE_CC})
#message(compiler: $${QMAKE_CXX})
#message(compiler: $${QMAKE_CFLAGS})
#message(compiler: $${QMAKE_CXXFLAGS})
#message(pro: $${_PRO_FILE_})
#message(pro: $${_PRO_FILE_PWD_})
QMAKEXSPEC = $$[QMAKE_XSPEC]

#win32
winrt {
    QSYS_PRIVATE = WinRT
}
else: msvc {
    QSYS_PRIVATE = MSVC
}
else: mingw {
    QSYS_PRIVATE = Windows
}
#macOS
#auto detect:iOSSimulator=iOS
else: ios {
    QSYS_PRIVATE = iOS
}
else: mac {
    QSYS_PRIVATE = macOS
}
#linux
else: android {
    QSYS_PRIVATE = Android
}
else: linux: cross_compile {
    QSYS_PRIVATE = Armhf32
}
else: linux {
    QSYS_PRIVATE = Linux64
}

#message(Multi-link detect platform: $${QSYS_PRIVATE}.)
#这里给用户开放了对比，如果用户发现自动检测出错了，在工程编译配置页面设置QSYS还是有效的。
QSYS_USERSETTING=$$(QSYS)
#如果用户设置，那么（自动检测）和用户设置对比，一样则依照Multi-link分辨平台，不一样则依照用户设置分辨平台。
!isEmpty(QSYS_USERSETTING):!equals(QSYS_PRIVATE, $${QSYS_USERSETTING}):QSYS_PRIVATE=$${QSYS_USERSETTING}
#如果用户不设置，那么按照detect继续下去，依照Multi-link分辨平台。
message(Multi-link make sure that the x-platform: $${QSYS_PRIVATE}.)

#mac iOS iOSSimulator
contains(QSYS_PRIVATE, macOS) {
    #unix private
    DEFINES += __UNIX__
    #darwin private
    DEFINES += __DARWIN__
    #darwin 64bit private
    DEFINES += __DARWIN64__
    #darwin desktop private
    DEFINES += __DESKTOP_DARWIN__
    #darwin desktop 64bit private
    DEFINES += __DESKTOP_DARWIN64__
} else:contains(QSYS_PRIVATE, iOS) {
    DEFINES += __UNIX__
    DEFINES += __DARWIN__
    DEFINES += __DARWIN64__
    #darwin embedded private
    DEFINES += __EMBEDDED_DARWIN__
    #darwin embedded 64bit private
    DEFINES += __EMBEDDED_DARWIN64__
    #iOS private
    DEFINES += __IOS__
    DEFINES += __IOS64__
} else:contains(QSYS_PRIVATE, iOSSimulator) {
    DEFINES += __UNIX__
    DEFINES += __DARWIN__
    DEFINES += __DARWIN64__
    DEFINES += __EMBEDDED_DARWIN__
    DEFINES += __EMBEDDED_DARWIN64__
    #iOS Simulator private = iOS
    DEFINES += __IOS__
    DEFINES += __IOS64__

#linux e-linux
} else:contains(QSYS_PRIVATE, Linux) {
    DEFINES += __UNIX__
    #linux private
    DEFINES += __LINUX__
    #linux 32bit private
    DEFINES += __LINUX32__
    #linux desktop private
    DEFINES += __DESKTOP_LINUX__
    #linux desktop 32bit private
    DEFINES += __DESKTOP_LINUX32__
} else:contains(QSYS_PRIVATE, Linux64) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    #linux 64bit private
    DEFINES += __LINUX64__
    DEFINES += __DESKTOP_LINUX__
    #linux desktop 64bit private
    DEFINES += __DESKTOP_LINUX64__
} else:contains(QSYS_PRIVATE, Embedded32|Embedded) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    #embedded common macro
    DEFINES += __EMBEDDED_LINUX__
    #embedded 32bit common macro
    DEFINES += __EMBEDDED_LINUX32__
} else:contains(QSYS_PRIVATE, Arm32|Arm) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    DEFINES += __EMBEDDED_LINUX__
    DEFINES += __EMBEDDED_LINUX32__
    #arm private
    DEFINES += __ARM_LINUX__
    #arm 32bit private
    DEFINES += __ARM_LINUX32__
} else:contains(QSYS_PRIVATE, Armhf32|Armhf) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    DEFINES += __EMBEDDED_LINUX__
    DEFINES += __EMBEDDED_LINUX32__
    DEFINES += __ARM_LINUX__
    DEFINES += __ARM_LINUX32__
    #armhf private
    DEFINES += __ARMHF_LINUX__
    #armhf 32bit private
    DEFINES += __ARMHF_LINUX32__
} else:contains(QSYS_PRIVATE, Mips32|Mips) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    DEFINES += __EMBEDDED_LINUX__
    DEFINES += __EMBEDDED_LINUX32__
    #mips private
    DEFINES += __MIPS_LINUX__
    #mips 32bit private
    DEFINES += __MIPS_LINUX32__

#android (e-linux的一种)
} else:contains(QSYS_PRIVATE, Android) {
    #Android系统对应主要CPU指令集架构为armeabi-v7a
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    DEFINES += __EMBEDDED_LINUX__
    DEFINES += __EMBEDDED_LINUX32__
    #android private
    DEFINES += __ANDROID__
    #android 32bit private
    DEFINES += __ANDROID32__
} else:contains(QSYS_PRIVATE, AndroidSimulator|Android32Simulator|AndroidX86) {
    DEFINES += __UNIX__
    DEFINES += __LINUX__
    DEFINES += __LINUX32__
    DEFINES += __EMBEDDED_LINUX__
    DEFINES += __EMBEDDED_LINUX32__
    DEFINES += __ANDROID__
    DEFINES += __ANDROID32__
    #android simulator private
    DEFINES += __ANDROIDX86__

#windows msvc winRT
} else:contains(QSYS_PRIVATE, Win32|Windows) {
    #win private
    DEFINES += __WIN__
    #win 32bit private
    DEFINES += __WIN32__
    #win desktop private
    DEFINES += __DESKTOP_WIN__
    #win desktop 32bit private
    DEFINES += __DESKTOP_WIN32__
} else:contains(QSYS_PRIVATE, Win64) {
    DEFINES += __WIN__
    #win 64bit private
    DEFINES += __WIN64__
    DEFINES += __DESKTOP_WIN__
    #win desktop 64bit private
    DEFINES += __DESKTOP_WIN64__
} else:contains(QSYS_PRIVATE, MSVC32|MSVC) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
    DEFINES += __DESKTOP_WIN__
    DEFINES += __DESKTOP_WIN32__
    #msvc private
    DEFINES += __MSVC__
    #msvc 32bit private
    DEFINES += __MSVC32__
} else:contains(QSYS_PRIVATE, MSVC64) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
    DEFINES += __DESKTOP_WIN__
    DEFINES += __DESKTOP_WIN64__
    DEFINES += __MSVC__
    #msvc 64bit private
    DEFINES += __MSVC64__
} else:contains(QSYS_PRIVATE, WinRT32|WinRT) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
    #win embedded private
    DEFINES += __EMBEDDED_WIN__
    #win embedded 32bit private
    DEFINES += __EMBEDDED_WIN32__
    #winrt private
    DEFINES += __WINRT__
    #winrt 32bit private
    DEFINES += __WINRT32__
} else:contains(QSYS_PRIVATE, WinRT32Simulator|WinRTSimulator) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
    DEFINES += __EMBEDDED_WIN__
    DEFINES += __EMBEDDED_WIN32__
    DEFINES += __WINRT__
    DEFINES += __WINRT32__
    #winrt simulator private = winrt
} else:contains(QSYS_PRIVATE, WinRT64) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
    DEFINES += __EMBEDDED_WIN__
    DEFINES += __EMBEDDED_WIN32__
    DEFINES += __WINRT__
    #winrt 64bit private
    DEFINES += __WINRT64__
} else:contains(QSYS_PRIVATE, WinRT64Simulator) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
    DEFINES += __EMBEDDED_WIN__
    DEFINES += __EMBEDDED_WIN32__
    DEFINES += __WINRT__
    DEFINES += __WINRT64__
    #winrt 64bit simulator private = winrt
}

#获取绝对路径的末尾
defineReplace(get_base_name){
    isEmpty(1):error("get_base_name(absolute_file_path) need one argument.")
    absolute_file_path = $$1
    absolute_file_path ~= s,\\,/,g
    file_path = $$absolute_file_path
    file_path ~= s:/[^/]*$::p
    base_name = $$replace(absolute_file_path, $$file_path/, "")
    return ($${base_name})
}

#获取绝对路径的路径
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

#message(add_platform.pri)
message(Build $${TARGET} to $${QSYS_PRIVATE} \(QSYS=$${QSYS_PRIVATE} is configed in project building page.\) )
message(Build $${TARGET} at $${QSYS_STD_DIR} \(Qt Kit page"," FileSystem Name=$${QSYS_PRIVATE}"," optional\) )
message(Build $${TARGET} on $${QMAKE_HOST.os} \(Operating System=$${QMAKE_HOST.os}\) )
message(Build $${TARGET} in $${OUT_PWD})
isEmpty(QSYS_PRIVATE) : message(Build $${TARGET} Qt Kit page FileSystem Name \(optionaled\) is decided by env variable QSYS. Please set it. )

isEmpty(QSYS_PRIVATE) {
    warning(env variable QSYS is required! pleace check add_platform.pri)
    error(error occured! please check build output panel.)
}

isEmpty(QSYS_PRIVATE) {
    warning(1. I suggest you change creator default build directory!)
    warning(2. env variable QSYS is required!)
    warning(pleace check add_platform.pri)
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
