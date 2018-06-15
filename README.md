# Multi-link Technology

#### 项目介绍  

为应用程序和链接库工程开发的，实现链接、发布依赖Library，发布SDK，发布应用，发布语言、配置等工程管理功能的多链接技术。  
Multi-link技术使用众多的pri进行函数定义，提供给用户丰富的App/Lib生产线操作函数，省却手动拷贝App、Lib、依赖令手痛的问题。  
我编写的Multi-link技术使用内置支持Library的方式支持众多的Library，方便共享对Library的支持，并且方便准确及时地同步到工程中进行使用，基本上编写一次，便不必再修改。  
用户有使用方便的Library可以给我发邮件，tianduanrui@163.com.把add_library_XXX.pri发给我。我会把它提交到Multi-link工程里。  


#### 软件架构  

[多链接技术的工程结构.xlsx](Multi-link.xlsx)  

#### 安装教程

1. 在用户主目录/.qmake/app_configure.pri里面配置三个变量
    - LIB_SDK_ROOT = /home/abel/Develop/b1-sdk
    - APP_BUILD_ROOT = /home/abel/Develop/c0-buildstation
    - APP_DEPLOY_ROOT = /home/abel/Develop/b0-product


#### 使用说明

1. 一个可以拷贝multi-link到自己工程目录，
    - 一个可以clone multi-link到公共位置
    - 一个可以clone multi-link到工程目录作为submodule。这个是推荐方式。
2. include (.../multi-link/add_base_manager.pri)
3. 仿照demo里的pri配置自己的工程。  
4. 如果希望添加自定义模块，那么从multi-link/app-lib里拷贝add_custom_manager.pri到工程目录。仿照demo里的样子写自定义的add_library_XXX.pri. 

[详细使用说明](usage.md)  

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request


#### 码云特技

1. 使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2. 码云官方博客 [blog.gitee.com](https://blog.gitee.com)
3. 你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解码云上的优秀开源项目
4. [GVP](https://gitee.com/gvp) 全称是码云最有价值开源项目，是码云综合评定出的优秀开源项目
5. 码云官方提供的使用手册 [http://git.mydoc.io/](http://git.mydoc.io/)
6. 码云封面人物是一档用来展示码云会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)