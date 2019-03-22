#-------------------------------------------------------------
#add_support.pri
#对第三方工具提供支持
#
#依赖add_multi_link_technology.pri
#依赖add_function.pri
#依赖add_platform.pri
#
#please don't modify this pri
#-------------------------------------------------------------
#对autotools工具管理的工程提供支持
#系统层的开源C库通常使用autoconf工具管理，
#制作Qt Wrapper的时候，直接迁移源代码比较困难，
#这里对config.h提供兼容，提供丰富的宏定义，帮助用户配置工程。
#直接迁移源代码，使用qmake生成源代码pri，就可以了，或许需要用户增加一点点的配置，那就简单很多了，这里帮助用户省略了很多重复劳动。
defineTest(add_support_autoconf){
    !isEmpty(1): error("add_support_autoconf() requires no argument")

    #e-linux linux
    contains(QSYS_PRIVATE, Embedded) {
        #embedded config macro
        #DEFINES += __EMBEDDED_LINUX__
    } else:contains(QSYS_PRIVATE, Arm32) {
        #DEFINES += __EMBEDDED_LINUX__
        #arm32 private
        #DEFINES += __ARM_LINUX__
    } else:contains(QSYS_PRIVATE, Armhf32) {
        #DEFINES += __EMBEDDED_LINUX__
        #arm32 private
        #DEFINES += __ARM_LINUX__
        #armhf32 private
        #DEFINES += __ARMHF_LINUX__
    } else:contains(QSYS_PRIVATE, Mips32) {
        #DEFINES += __EMBEDDED_LINUX__
        #mips32 private
        #DEFINES += __MIPS_LINUX__
    } else:contains(QSYS_PRIVATE, Linux) {
        #DEFINES += __LINUX__
        #DEFINES += __LINUX32__
    } else:contains(QSYS_PRIVATE, Linux64) {
        #DEFINES += __LINUX__
        #DEFINES += __LINUX64__

    #windows msvc
    } else:contains(QSYS_PRIVATE, Win32|Windows) {
        #DEFINES += __WIN__
        #DEFINES += __WIN32__
        DEFINES += HAVE_ASSERT_H=1
        DEFINES += HAVE_ERRNO_H=1

        DEFINES += HAVE_DLFCN_H=1

        DEFINES += HAVE_FCNTL=1
        DEFINES += HAVE_FCNTL_H=1

        DEFINES += HAVE_FORK=1

        DEFINES += HAVE_INTTYPES_H=1
        DEFINES += HAVE_STDINT_H=1
        DEFINES += HAVE_STDLIB_H=1
        DEFINES += HAVE_UNISTD_H=1
        DEFINES += STDC_HEADERS=1

        DEFINES += HAVE_STRING_H=1
        DEFINES += HAVE_STRINGS_H=1

        DEFINES += HAVE_SYS_STAT_H=1
        DEFINES += HAVE_SYS_TYPES_H=1
        DEFINES += HAVE_WAITPID=1

        DEFINES += SIZEOF_SHORT=2
        DEFINES += SIZEOF_UINT16_T=2
        DEFINES += SIZEOF_U_INT16_T=2

        DEFINES += SIZEOF_UINT32_T=4
        DEFINES += SIZEOF_U_INT32_T=4
        DEFINES += SIZEOF_INT=4
        DEFINES += SIZEOF_LONG=4
        DEFINES += SIZEOF_LONG_LONG=8

        DEFINES += HAVE_LIMITS_H=1
        DEFINES += HAVE_MEMORY_H=1
        DEFINES += HAVE_PIPE_H=1

        DEFINES += HAVE_GETOPT_H=1
        DEFINES += HAVE_GETOPT_LONG=1
    } else:contains(QSYS_PRIVATE, Win64) {
        #DEFINES += __WIN__
        #DEFINES += __WIN64__
    } else:contains(QSYS_PRIVATE, WinRT) {
        #DEFINES += __WIN__
        #DEFINES += __WINRT__
    } else:contains(QSYS_PRIVATE, MSVC32|MSVC) {
        #DEFINES += __WIN__
        #DEFINES += __WIN32__
        #DEFINES += __MSVC__
        #DEFINES += __MSVC32__
        DEFINES += HAVE_ASSERT_H=1
        DEFINES += HAVE_ERRNO_H=1

        #DEFINES += HAVE_DLFCN_H=1

        #DEFINES += HAVE_FCNTL=1
        DEFINES += HAVE_FCNTL_H=1

        #DEFINES += HAVE_FORK=1

        DEFINES += HAVE_INTTYPES_H=1
        DEFINES += HAVE_STDINT_H=1
        DEFINES += HAVE_STDLIB_H=1
        DEFINES += HAVE_UNISTD_H=1
        DEFINES += STDC_HEADERS=1

        DEFINES += HAVE_STRING_H=1
        DEFINES += HAVE_STRINGS_H=1

        DEFINES += HAVE_SYS_STAT_H=1
        DEFINES += HAVE_SYS_TYPES_H=1
        #DEFINES += HAVE_SYS_WAIT_H=1
        #DEFINES += HAVE_WAITPID=1

        DEFINES += SIZEOF_SHORT=2
        DEFINES += SIZEOF_UINT16_T=2
        DEFINES += SIZEOF_U_INT16_T=2

        DEFINES += SIZEOF_UINT32_T=4
        DEFINES += SIZEOF_U_INT32_T=4
        DEFINES += SIZEOF_INT=4
        DEFINES += SIZEOF_LONG=4
        DEFINES += SIZEOF_LONG_LONG=8

        DEFINES += HAVE_LIMITS_H=1
        DEFINES += HAVE_MEMORY_H=1
        #DEFINES += HAVE_PIPE=1
        DEFINES += HAVE_PIPE_H=1

        DEFINES += HAVE_GETOPT_H=1
        DEFINES += HAVE_GETOPT_LONG=1
    } else:contains(QSYS_PRIVATE, MSVC64) {
        #DEFINES += __WIN__
        #DEFINES += __WIN64__
        #DEFINES += __MSVC__
        #DEFINES += __MSVC64__

    #ios mac
    } else:contains(QSYS_PRIVATE, macOS) {
        #DEFINES += __DARWIN__
        DEFINES += HAVE_ASSERT_H=1
        DEFINES += HAVE_ERRNO_H=1

        DEFINES += HAVE_DLFCN_H=1

        DEFINES += HAVE_FCNTL=1
        DEFINES += HAVE_FCNTL_H=1

        DEFINES += HAVE_FORK=1

        DEFINES += HAVE_INTTYPES_H=1
        DEFINES += HAVE_STDINT_H=1
        DEFINES += HAVE_STDLIB_H=1
        DEFINES += HAVE_UNISTD_H=1
        DEFINES += STDC_HEADERS=1

        DEFINES += HAVE_STRING_H=1
        DEFINES += HAVE_STRINGS_H=1

        DEFINES += HAVE_SYS_STAT_H=1
        DEFINES += HAVE_SYS_TYPES_H=1
        DEFINES += HAVE_WAITPID=1

        DEFINES += SIZEOF_SHORT=2
        DEFINES += SIZEOF_UINT16_T=2
        DEFINES += SIZEOF_U_INT16_T=2

        DEFINES += SIZEOF_UINT32_T=4
        DEFINES += SIZEOF_U_INT32_T=4
        DEFINES += SIZEOF_INT=4
        DEFINES += SIZEOF_LONG=4
        DEFINES += SIZEOF_LONG_LONG=8

        DEFINES += HAVE_LIMITS_H=1
        DEFINES += HAVE_MEMORY_H=1
        DEFINES += HAVE_PIPE_H=1

        DEFINES += HAVE_GETOPT_H=1
        DEFINES += HAVE_GETOPT_LONG=1
    } else:contains(QSYS_PRIVATE, iOS) {
        #DEFINES += __IOS__
    } else:contains(QSYS_PRIVATE, iOSSimulator) {
        #DEFINES += __IOS__
        #TODO:no qcustomplot word printer process

    #android
    } else:contains(QSYS_PRIVATE, Android) {
        #Android系统对应主要CPU指令集架构为armeabi-v7a
        #DEFINES += __ANDROID__
        DEFINES += HAVE_ASSERT_H=1
        DEFINES += HAVE_ERRNO_H=1

        DEFINES += HAVE_DLFCN_H=1

        DEFINES += HAVE_FCNTL=1
        DEFINES += HAVE_FCNTL_H=1

        DEFINES += HAVE_FORK=1

        DEFINES += HAVE_INTTYPES_H=1
        DEFINES += HAVE_STDINT_H=1
        DEFINES += HAVE_STDLIB_H=1
        DEFINES += HAVE_UNISTD_H=1
        DEFINES += STDC_HEADERS=1

        DEFINES += HAVE_STRING_H=1
        DEFINES += HAVE_STRINGS_H=1

        DEFINES += HAVE_SYS_STAT_H=1
        DEFINES += HAVE_SYS_TYPES_H=1
        DEFINES += HAVE_WAITPID=1

        DEFINES += SIZEOF_INT=4
        DEFINES += SIZEOF_LONG=4
        DEFINES += SIZEOF_LONG_LONG=8

        DEFINES += HAVE_LIMITS_H=1
        DEFINES += HAVE_MEMORY_H=1
        DEFINES += HAVE_PIPE_H=1
    } else:contains(QSYS_PRIVATE, AndroidX86) {
        #DEFINES += __ANDROID__
        #DEFINES += __ANDROIDX86__
    }

    export(DEFINES)

    return (1)
}

#静态链接MultiThread库 LIBCMT[D].LIB
#link_static_mt, release:/MT debug:/MTd
#动态链接MultiThread库 MSVCRT[D].LIB MSVCRT[D].DLL
#link_mt, release:/MD debug:/MDd

#在内存管理方面，link_mt 有优势，用户DLL、LIB、APP只使用同一套MT-DLL的代码。
#用户程序体积小
#用户不必携带VS运行库，安装VS2015 VS2017运行时库即可。
#二选一，一般选择 link_mt

#link_mt
defineTest(add_support_msvc_link_mt){

    LINKFLAG =
    CONFIG(debug, debug|release|profile){
        #动态链接 MSVCRTD.LIB MSVCRTD.DLL
        LINKFLAG += /MDd /O2 /Zi
    } else:CONFIG(release, debug|release|profile){
        #动态链接 MSVCRT.LIB MSVCRT.DLL
        LINKFLAG += /MD /O2 /Zi
    } else {
        #动态链接 MSVCRT.LIB MSVCRT.DLL
        LINKFLAG += /MD /O2 /Zi
    }

    #/MD[d] 必须要这个宏
    DEFINES += _AFXDLL

    QMAKE_CFLAGS += $${LINKFLAG}
    QMAKE_CXXFLAGS += $${LINKFLAG}

    #清理静态链接的FLAG
    LINK0FLAG = /MT /MTd
    QMAKE_CFLAGS -= $${LINK0FLAG}
    QMAKE_CXXFLAGS -= $${LINK0FLAG}

    export(QMAKE_CFLAGS)
    export(QMAKE_CXXFLAGS)
    export(DEFINES)

    return (1)
}

#link_static_mt
defineTest(add_support_msvc_link_static_mt){

    LINKFLAG =
    CONFIG(debug, debug|release|profile){
        #静态链接 LIBCMTD.LIB
        LINKFLAG += /MTd /O2 /Zi
    } else:CONFIG(release, debug|release|profile){
        #静态链接 LIBCMT.LIB
        LINKFLAG += /MT /O2 /Zi
    } else {
        #静态链接 LIBCMT.LIB
        LINKFLAG += /MT /O2 /Zi
    }

    QMAKE_CFLAGS += $${LINKFLAG}
    QMAKE_CXXFLAGS += $${LINKFLAG}

    #清理动态链接的FLAG
    LINK0FLAG = /MD /MDd
    QMAKE_CFLAGS -= $${LINK0FLAG}
    QMAKE_CXXFLAGS -= $${LINK0FLAG}

    export(QMAKE_CFLAGS)
    export(QMAKE_CXXFLAGS)

    return (1)
}

#并行编译
#/MP
defineTest(add_support_msvc_parallel){
    #非并发编译还是有点用的，IDE不至于卡死。
    LINKFLAG = /MP

    QMAKE_CFLAGS += $${LINKFLAG}
    QMAKE_CXXFLAGS += $${LINKFLAG}
    export(QMAKE_CFLAGS)
    export(QMAKE_CXXFLAGS)

    return (1)
}
