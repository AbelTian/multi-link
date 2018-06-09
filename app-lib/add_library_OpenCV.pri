#----------------------------------------------------------------
#add_library_OpenCV.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------

#######################################################################################
#初始化设置
#######################################################################################
LIBRARYVER = 231


#######################################################################################
#定义内部函数
#######################################################################################
#修改
defineTest(add_include_OpenCV){
    #不为空，肯定是源码里的路径。 用于导出头文件
    header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    isEmpty(header_path)header_path=$$get_add_include(OpenCV)

    command =
    #basic
    command += $${header_path}
    command += $${header_path}/opencv
    command += $${header_path}/opencv2
    command += $${header_path}/opencv2/calib3d
    command += $${header_path}/opencv2/contrib
    command += $${header_path}/opencv2/core
    command += $${header_path}/opencv2/features2d
    command += $${header_path}/opencv2/flann
    command += $${header_path}/opencv2/gpu
    command += $${header_path}/opencv2/highgui
    command += $${header_path}/opencv2/imgproc
    command += $${header_path}/opencv2/legacy
    command += $${header_path}/opencv2/ml
    command += $${header_path}/opencv2/objdetect
    command += $${header_path}/opencv2/video

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_OpenCV){
    #添加这个SDK里的defines
    #add_defines()

    return (1)
}

defineTest(add_library_OpenCV){
    #链接Library
    add_library(OpenCV, opencv_calib3d$${LIBRARYVER})
    add_library(OpenCV, opencv_contrib$${LIBRARYVER})
    add_library(OpenCV, opencv_core$${LIBRARYVER})
    add_library(OpenCV, opencv_features2d$${LIBRARYVER})
    add_library(OpenCV, opencv_flann$${LIBRARYVER})
    add_library(OpenCV, opencv_gpu$${LIBRARYVER})
    add_library(OpenCV, opencv_highgui$${LIBRARYVER})
    add_library(OpenCV, opencv_imgproc$${LIBRARYVER})
    add_library(OpenCV, opencv_legacy$${LIBRARYVER})
    add_library(OpenCV, opencv_ml$${LIBRARYVER})
    add_library(OpenCV, opencv_objdetect$${LIBRARYVER})
    add_library(OpenCV, opencv_video$${LIBRARYVER})
    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
defineTest(add_deploy_library_OpenCV) {
    add_deploy_library(OpenCV, opencv_calib3d$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_contrib$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_core$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_features2d$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_flann$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_gpu$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_highgui$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_imgproc$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_legacy$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_ml$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_objdetect$${LIBRARYVER})
    add_deploy_library(OpenCV, opencv_video$${LIBRARYVER})
    return (1)
}
