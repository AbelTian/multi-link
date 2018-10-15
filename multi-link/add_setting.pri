#-------------------------------------------------------------
#add_setting.pri
#app对multi-link函数进行配置。

#依赖add_multi_link_technology.pri
#依赖add_function.pri
#依赖add_platform.pri
#依赖add_project.pri
#-------------------------------------------------------------
#Multi-link技术 add_deploy部分只能应用于Qt5，Qt4没有windeployqt程序，如果用户为Qt4编译了windeployqt那么也可以用于Qt4。

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
#默认就是工程目标的位置。可以强制改变为其他目标的位置。
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
