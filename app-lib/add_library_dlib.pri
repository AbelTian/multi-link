#----------------------------------------------------------------
#add_library_dlib.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#19.13

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_dlib){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(dlib, dlib)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include(dlib, dlib)
    command += $${header_path}
    command += $${header_path}/all
    command += $${header_path}/any
    command += $${header_path}/array
    command += $${header_path}/array2d
    command += $${header_path}/base64
    command += $${header_path}/bayes_utils
    command += $${header_path}/bigint
    command += $${header_path}/binary_search_tree
    command += $${header_path}/bit_stream
    command += $${header_path}/bound_function_pointer
    command += $${header_path}/bridge
    command += $${header_path}/bsp
    command += $${header_path}/byte_orderer
    command += $${header_path}/clustering
    command += $${header_path}/cmake_utils
    command += $${header_path}/cmake_utils/test_for_cpp11
    command += $${header_path}/cmake_utils/test_for_cuda
    command += $${header_path}/cmake_utils/test_for_cudnn
    command += $${header_path}/cmd_line_parser
    command += $${header_path}/compress_stream
    command += $${header_path}/conditioning_class
    command += $${header_path}/config_reader
    command += $${header_path}/control
    command += $${header_path}/cpp_pretty_printer
    command += $${header_path}/cpp_tokenizer
    command += $${header_path}/crc32
    command += $${header_path}/data_io
    command += $${header_path}/dir_nav
    command += $${header_path}/directed_graph
    command += $${header_path}/disjoint_subsets
    command += $${header_path}/dnn
    command += $${header_path}/entropy_decoder
    command += $${header_path}/entropy_decoder_model
    command += $${header_path}/entropy_encoder
    command += $${header_path}/entropy_encoder_model
    command += $${header_path}/external
    command += $${header_path}/external/cblas
    command += $${header_path}/external/libjpeg
    command += $${header_path}/external/libpng
    command += $${header_path}/external/libpng/arm
    command += $${header_path}/external/zlib
    command += $${header_path}/filtering
    command += $${header_path}/general_hash
    command += $${header_path}/geometry
    command += $${header_path}/graph
    command += $${header_path}/graph_cuts
    command += $${header_path}/graph_utils
    command += $${header_path}/gui_core
    command += $${header_path}/gui_widgets
    command += $${header_path}/hash_map
    command += $${header_path}/hash_set
    command += $${header_path}/hash_table
    command += $${header_path}/http_client
    command += $${header_path}/image_keypoint
    command += $${header_path}/image_loader
    command += $${header_path}/image_processing
    command += $${header_path}/image_saver
    command += $${header_path}/image_transforms
    command += $${header_path}/interfaces
    command += $${header_path}/iosockstream
    command += $${header_path}/linker
    command += $${header_path}/logger
    command += $${header_path}/lsh
    command += $${header_path}/lz77_buffer
    command += $${header_path}/lzp_buffer
    command += $${header_path}/manifold_regularization
    command += $${header_path}/map
    command += $${header_path}/matlab
    command += $${header_path}/matrix
    command += $${header_path}/matrix/lapack
    command += $${header_path}/md5
    command += $${header_path}/member_function_pointer
    command += $${header_path}/memory_manager
    command += $${header_path}/memory_manager_global
    command += $${header_path}/memory_manager_stateless
    command += $${header_path}/misc_api
    command += $${header_path}/mlp
    command += $${header_path}/numerical_integration
    command += $${header_path}/opencv
    command += $${header_path}/optimization
    command += $${header_path}/pipe
    command += $${header_path}/python
    command += $${header_path}/quantum_computing
    command += $${header_path}/queue
    command += $${header_path}/rand
    command += $${header_path}/reference_counter
    command += $${header_path}/sequence
    command += $${header_path}/server
    command += $${header_path}/set
    command += $${header_path}/set_utils
    command += $${header_path}/simd
    command += $${header_path}/sliding_buffer
    command += $${header_path}/smart_pointers
    command += $${header_path}/sockets
    command += $${header_path}/sockstreambuf
    command += $${header_path}/sqlite
    command += $${header_path}/stack
    command += $${header_path}/static_map
    command += $${header_path}/static_set
    command += $${header_path}/statistics
    command += $${header_path}/stl_checked
    command += $${header_path}/string
    command += $${header_path}/svm
    command += $${header_path}/sync_extension
    command += $${header_path}/test
    command += $${header_path}/test/blas_bindings
    command += $${header_path}/test/examples
    command += $${header_path}/test/gui
    command += $${header_path}/test/tools
    command += $${header_path}/threads
    command += $${header_path}/timeout
    command += $${header_path}/timer
    command += $${header_path}/tokenizer
    command += $${header_path}/tuple
    command += $${header_path}/type_safe_union
    command += $${header_path}/unicode
    command += $${header_path}/vectorstream
    command += $${header_path}/xml_parser

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_dlib){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 dlib 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 dlib 的自有控制宏，
    #留意 dlib 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 dlib 使用的控制宏，修改 dlib 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #dlib 动态编译时
    contains(DEFINES, DLIB_LIBRARY){
        message($${TARGET} build dlib dynamic library)
    }
    #dlib 静态编译、链接时
    else:contains(DEFINES, DLIB_STATIC_LIBRARY){
        message($${TARGET} build-link dlib static library)
    }
    #dlib 动态链接时
    else:!contains(DEFINES, DLIB_LIBRARY){
        message($${TARGET} link dlib dynamic library)
    }

    #--------------------------------------------
    #添加库的宏配置信息，编译时、链接时通用，需要注意区分不同宏控制
    #建议先写动态编译、链接时的通用配置，然后增加对动态编译、链接，对静态编译、链接时的兼容处理。处理多个子模块时特别好用。
    #--------------------------------------------

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_dlib){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(dlib, dlib)
    add_library(dlib, dlib)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_dlib) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(dlib)
    #add_deploy_library(dlib, dlib)
    add_deploy_library(dlib, dlib)

    return (1)
}
