#---------------------------------------------------------------------------------
#add_base_manager.pri
#应用程序和Library的基础管理器，统一使用这个管理器。
#base header包揽所有的app和lib的通用设置
#base manager包揽所有app和lib启动的函数
#V2
#和同目录下pri组一同拷贝使用，不拷贝可以使用。建议不拷贝使用，可以跟进技术更新。
#设计难度：控制难度，丰富接口。
#在Multi-PC、Multi-plat开发的时候，能够体现优势。
#---------------------------------------------------------------------------------
#简介
#在这个管理器里，App和Lib工程其实是区分开的。
#尤其动态编译 配置开关、宏定义 是在这里处理的，但是静态编译 配置开关在这里、宏定义在base_header里。这里需要加强理解。
#这是重点。

################################################################################
#初始化
################################################################################
ADD_BASE_MANAGER_PRI_PWD = $${PWD}

################################################################################
#包含这个pri依赖的pri
#设置目标平台 QSYS
################################################################################
include ($${PWD}/add_platform.pri)
include ($${PWD}/add_function.pri)

################################################################################
#多链接技术入口
#配置重要的三个路径 APP_BUILD_ROOT APP_DEPLOY_ROOT LIB_SDK_ROOT
################################################################################
include($${PWD}/add_multi_link_technology.pri)

################################################################################
#这里的pri提供multi link的全部函数
################################################################################
#增加发布
#增加发布配置
#增加链接库
#增加链接库头文件
#增加SDK (lib用)
#增加版本信息

#app发布所需要的函数
include ($${PWD}/add_deploy.pri)

#app发布library所需要的函数
include ($${PWD}/add_deploy_library.pri)

#app发布配置项需要的函数
include ($${PWD}/add_deploy_config.pri)

#链接lib所需要的函数 包含lib头文件所需要的函数 设置lib宏所需要的函数
include ($${PWD}/add_library.pri)

#lib发布sdk所需要的函数
#注释：提供修改Target名字的函数
include ($${PWD}/add_sdk.pri)

#lib发布Qt Desinger plugins所需要的函数
#include ($${PWD}/add_plugin.pri)

#program version
include ($${PWD}/add_version.pri)

#program language
include ($${PWD}/add_language.pri)

#program icons (app only)
include ($${PWD}/add_icons.pri)

#support autotool project
include ($${PWD}/add_support_autoconf.pri)

####################################################################################
#工程常用的函数
####################################################################################
include ($${PWD}/add_project.pri)

####################################################################################
#经过上面的一些步骤，multi-link初始化完毕。
#用户可以调用这里的一些函数对multi-link的功能进行设置。
#默认是不用设置的，只有一些特别的功能需要。
####################################################################################
include($${PWD}/add_setting.pri)

####################################################################################
#base manager 都做了以下这些事情
####################################################################################
#执行一些初始工程工作。

#################################################################
##definition and configration
##need QSYS
#################################################################
#这个编译，build pane比较简洁
#CONFIG += silent
#multi-link v2.0对这个功能有良好的支持。
#CONFIG += debug_and_release
#编译全部
#CONFIG += build_all

#修饰TARGET LIB必要 APP可选 only once
#此处提醒用户：你肯定不愿意手动调用。

#格式
#debug版本，_debug d，无论app lib，还是链接的lib，发布的lib，和发布的sdk都是这样的。
#release版本，没有后缀。
#用户在链接库的时候，需要分类处理，debug版本和release版本，准备哪种版本，才能链接哪种版本。
#

add_decorate_target($${TARGET_NAME})

contains(TEMPLATE, app) {
    #启动app工程 APP必要
    add_app_project()
} else: contains(TEMPLATE, lib) {
    #启动lib工程 LIB必要
    add_lib_project()
}

#################################################################
#公共的基础header.pri，这个的作用在于不需要区分app和lib的设置都在这里面。
#包含基本的编译设置
#这个header在所有的函数包含完以后，添加，因为这个header其实也依赖Multi-link技术。但是，执行却是在所有的函数前边。
#################################################################
include ($${PWD}/add_base_header.pri)


#debug ...
#message($$TARGET qt $$QT)
#message($$TARGET config $$CONFIG)
#message($$TARGET define $$DEFINES)
#message($$TARGET pre link $$QMAKE_PRE_LINK)
#message($$TARGET post link $$QMAKE_POST_LINK)
