#-------------------------------------------------------------
#add_setting.pri
#对multi-link函数群进行配置，一次配置影响一个函数功能类群。

#依赖add_multi_link_technology.pri
#依赖add_function.pri
#依赖add_platform.pri
#依赖add_project.pri

#please don't modify this pri
#-------------------------------------------------------------

################################################################################
#内部用函数
#获取命令
################################################################################
ADD_SETTING_PRI_PWD = $${PWD}

##########################################
#
##########################################

################################################################################
#外部用函数
#执行命令
################################################################################
##########################################
#app对发布函数的设置命令
#这个函数会影响add_deploy系列功能函数，迫使改变add_deploy函数群发布位置。
#默认就是app工程目标DEPLOY的位置。可以强制改变为其他目标DEPLOY的位置。
#这个函数主要用于集中发布各个不同工程目标到相同工程组目标的时候。
#不会影响到build室的发布。
##########################################
APP_DEPLOY_TARGET_NAME=$${TARGET_NAME}
defineTest(add_setting_deploy){
    isEmpty(1): error("add_setting_deploy(appgroupname) requires one argument")
    !isEmpty(2): error("add_setting_deploy(appgroupname) requires one argument")
    appgroupname = $$1
    APP_DEPLOY_TARGET_NAME = $${appgroupname}
    export(APP_DEPLOY_TARGET_NAME)
    return(true)
}

##########################################
#lib对发布函数的设置命令
#这个函数会影响add_sdk系列功能函数，迫使改变add_sdk函数群发布位置。
#默认就是lib工程目标SDK的位置。可以强制改变为其他目标SDK的位置。
#这个函数主要用于集中发布各个不同工程目标到相同工程组目标的时候。
#不会影响到build室的发布。
##########################################
LIB_SDK_TARGET_NAME=$${TARGET_NAME}
defineTest(add_setting_sdk){
    isEmpty(1): error("add_setting_sdk(libgroupname) requires one argument")
    !isEmpty(2): error("add_setting_sdk(libgroupname) requires one argument")
    libgroupname = $$1
    LIB_SDK_TARGET_NAME = $${libgroupname}
    export(LIB_SDK_TARGET_NAME)
    return(true)
}

##########################################
#lib对编译过程的设置命令
#这个函数会影响add_x_library_project系列功能函数，迫使改变链接库自有宏的名称。
#默认就是lib工程目标名。可以强制改变为其他目标名。
#这个函数主要用于强制一组链接库使用同一组自有宏的时候，用于强制链接库群体以同样的方式编译、链接。
##########################################
LIB_BUILD_TARGET_NAME=$${TARGET_NAME}
defineTest(add_setting_build){
    isEmpty(1): error("add_setting_build(libgroupname) requires one argument")
    !isEmpty(2): error("add_setting_build(libgroupname) requires one argument")
    libgroupname = $$1
    LIB_BUILD_TARGET_NAME = $${libgroupname}
    export(LIB_BUILD_TARGET_NAME)
    return(true)
}

##########################################
#app/lib对依赖Qt的过程的设置命令
#这个函数会影响add_deploy系列功能函数，迫使add_deploy函数群[不]启动对Qt的windeployqt发布操作。
##########################################
MULTI_LINK_WITH_QT=true
#默认开启
#参数1 true：开启Qt过程，false：关闭Qt过程
defineTest(add_setting_with_qt){
    isEmpty(1): error("add_setting_with_qt(switch) requires one argument")
    !isEmpty(2): error("add_setting_with_qt(switch) requires one argument")
    MULTI_LINK_WITH_QT = $$1
    !equals(MULTI_LINK_WITH_QT, false):MULTI_LINK_WITH_QT=true
    export(MULTI_LINK_WITH_QT)
    return(true)
}


##########################################
#app/lib对依赖Qt QML的过程的设置命令
#这个函数会影响add_deploy系列功能函数，迫使add_deploy函数群[不]启动对Qt的windeployqt中QML的发布支持操作。
##########################################
MULTI_LINK_WITH_QML=false
#默认关闭
#参数1 true：开启Qt的QML发布过程，false：关闭Qt的QML发布过程
defineTest(add_setting_with_qml){
    isEmpty(1): error("add_setting_with_qml(switch) requires one argument")
    !isEmpty(2): error("add_setting_with_qml(switch) requires one argument")
    MULTI_LINK_WITH_QML = $$1
    !equals(MULTI_LINK_WITH_QML, false):MULTI_LINK_WITH_QML=true
    export(MULTI_LINK_WITH_QML)
    return(true)
}
