#----------------------------------------------------------------
#add_custom_manager.pri
#这个文件用于给用户自定义管理内容，随意添加自己所需要的library、defines、config等等。
#拷贝到用户app工程目录里使用用
#建议拷贝走使用。
#----------------------------------------------------------------

################################################################
##基础使用方法
################################################################
#添加app版本
#add_version (1,0,0,0)

#添加依赖library
#add_library(xx)
#add_include(xx)
#add_defines(xx)

#先发布App
#app从build到deploy
#add_deploy()

#后发布依赖
#lib从sdk到build和deploy
#add_deploy_library(xx)

################################################################
##高级使用方法
################################################################
#从multi-link/app-lib里添加add_library_XXX.pri
#add_dependent_manager(XXX)
#从当前路径添加add_library_XXX.pri，允许指定路径。
#add_custom_dependent_manager(XXX)
