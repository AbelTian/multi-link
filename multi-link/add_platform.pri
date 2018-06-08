#-----------------------------------------------------------------------------
#app_platform.pri
#这个pri决定编译目标平台
#-----------------------------------------------------------------------------
#从环境变量读取QSYS保存为qmake变量QSYS_PRIVATE

#在Multi-link 2.0以后，采用QKIT和QSYS配合的方式指定编译目标，依然在工程编译的配置里环境变量区域进行配置。
#其含义在于指定目标操作系统和目标CPU平台。

#以下给出QKIT与QSYS建议值。QKIT代表目标操作系统（非开发机操作系统），QSYS代表目标系统运行在CPU架构（CPU指令集、或说CPU平台）。
#QKIT Windows
#QSYS Windows(默认，这是是说32位) Win32(intelx86!=amdx86) Win64(amd64也可以) WinRT Winx86_64

#QKIT macOS
#QSYS macOS(默认，amd64也可以)

#QKIT iOS
#QSYS iOS（默认） iOSSimulator

#QKIT Linux
#QSYS Linux Linux32 Linux64（默认） arm32 arm64 mips32 embedded

#QKIT Android
#QSYS Android(默认，特指armeabi-v7a) armeabi armeabi-v7a armeabi-v8 armeabi64

#这样做的好处在于，对于不同操作系统下的不同的CPU平台都能做到良好的Library适配。为了SDK而产生这样的结构。
#像Android系统，对多种native c++ SDK的支持就很好用了。

#系统上SDK的位置 SDKROOT/xxxSDK/Windows/Win32/bin
#                                          /lib
#                                          /include
#Multi-link会从SDK的相应位置加载相应的SDK。
#如果用户不设置QSYS，Multi-link会设置相应的默认值，也是建议值。

QKIT_PRIVATE = $$(QKIT)
QSYS_PRIVATE = $$(QSYS)

contains(QSYS_PRIVATE, Embedded) {
    #embedded common macro
    DEFINES += __EMBEDDED_LINUX__
} else:contains(QSYS_PRIVATE, Arm32) {
    DEFINES += __EMBEDDED_LINUX__
    #arm32 private
    DEFINES += __ARM_LINUX__
} else:contains(QSYS_PRIVATE, Mips32) {
    DEFINES += __EMBEDDED_LINUX__
    #mips32 private
    DEFINES += __MIPS_LINUX__
} else:contains(QSYS_PRIVATE, Linux) {
    DEFINES += __LINUX__
} else:contains(QSYS_PRIVATE, Linux64) {
    DEFINES += __LINUX__
    DEFINES += __LINUX64__
} else:contains(QSYS_PRIVATE, Win32|Windows) {
    DEFINES += __WIN__
    DEFINES += __WIN32__
} else:contains(QSYS_PRIVATE, Win64) {
    DEFINES += __WIN__
    DEFINES += __WIN64__
} else:contains(QSYS_PRIVATE, WinRT) {
    DEFINES += __WIN__
    DEFINES += __WINRT__
} else:contains(QSYS_PRIVATE, macOS) {
    DEFINES += __DARWIN__
} else:contains(QSYS_PRIVATE, iOS) {
    DEFINES += __IOS__
} else:contains(QSYS_PRIVATE, iOSSimulator) {
    DEFINES += __IOS__
    #TODO:no qcustomplot word printer process
} else:contains(QSYS_PRIVATE, Android) {
    DEFINES += __ANDROID__
} else:contains(QSYS_PRIVATE, AndroidX86) {
    DEFINES += __ANDROID__
    DEFINES += __ANDROIDX86__ #可能废弃
}

BUILD=
CONFIG(debug, debug|profile|release):BUILD=Debug
CONFIG(profile, debug|profile|release):BUILD=Profile
CONFIG(release, debug|profile|release):BUILD=Release

#在新的改进里，准备废弃这个路径。至少和编译路径脱开关系。
QSYS_STD_DIR = $${QSYS_PRIVATE}/$${QT_VERSION}/$${BUILD}
QSYS_STD_DIR = $${QSYS_PRIVATE}/$${QT_VERSION}
QSYS_STD_DIR = $${QSYS_PRIVATE}

message(add_platform.pri)
message(Build $${TARGET} to $${QSYS_PRIVATE} \(QSYS=$${QSYS_PRIVATE} is configed in project build page.\) )
message(Build $${TARGET} at $${QSYS_STD_DIR} \(Qt Kit page FileSystem Name=$${QSYS_PRIVATE}\) )
message(Build $${TARGET} on $${QMAKE_HOST.os} \(Operating System=$${QMAKE_HOST.os}\) )
isEmpty(QSYS_PRIVATE) : message(Build $${TARGET} Qt Kit page FileSystem Name is decided by env variable QSYS. Please set it. )

isEmpty(QSYS_PRIVATE) {
    message(1. you should change qt default build directory to your-pc-build-station/%{CurrentProject:Name}/%{CurrentKit:FileSystemName})
    message(2. env variable QSYS is required! pleace check app_platform.pri)
    error(error occured! please check build output panel.)
}

isEmpty(QSYS_PRIVATE) {
    message(env variable QSYS is required!)
    message(pleace check app_platform.pri)
    error("error occured, please check build output panel.")
}


#in theory, this should not be limited to 4.8.0, no limit is good.
lessThan(QT_VERSION, 4.8.0) {
    message(A. ensure your compiler support c++11 feature)
    message(B. suggest Qt version >= 4.8.0)
    #error(  error occured!)
}
