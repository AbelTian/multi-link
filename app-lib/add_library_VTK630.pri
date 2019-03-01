#----------------------------------------------------------------
#add_library_VTK630.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################


#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_VTK630){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(VTK630, vtk-6.3)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    command += $${header_path}/alglib
    command += $${header_path}/vtkexpat
    command += $${header_path}/vtkfreetype
    command += $${header_path}/vtkfreetype/include
    command += $${header_path}/vtkfreetype/include/freetype
    command += $${header_path}/vtkfreetype/include/freetype/config
    command += $${header_path}/vtkgl2ps
    command += $${header_path}/vtkgl2ps/include
    command += $${header_path}/vtkhdf5
    command += $${header_path}/vtkjpeg
    command += $${header_path}/vtkjsoncpp
    command += $${header_path}/vtkjsoncpp/json
    command += $${header_path}/vtklibproj4
    command += $${header_path}/vtklibxml2
    command += $${header_path}/vtklibxml2/libxml
    command += $${header_path}/vtkmetaio
    command += $${header_path}/vtknetcdf
    command += $${header_path}/vtknetcdf/include
    command += $${header_path}/vtkoggtheora
    command += $${header_path}/vtkoggtheora/include
    command += $${header_path}/vtkoggtheora/include/ogg
    command += $${header_path}/vtkoggtheora/include/theora
    command += $${header_path}/vtkpng
    command += $${header_path}/vtksqlite
    command += $${header_path}/vtksys
    command += $${header_path}/vtksys/ios
    command += $${header_path}/vtksys/stl
    command += $${header_path}/vtktiff
    command += $${header_path}/vtkverdict
    command += $${header_path}/vtkzlib

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_VTK630){
    #添加这个SDK里的defines
    #add_defines()


    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_static_defines_VTK630){
    #如果链接静态库，那么开启。编译也开启。
    DEFINES += VTK630_STATIC_LIBRARY

    add_defines_VTK630()

    export(DEFINES)
    return (1)
}

#留意
defineTest(add_library_VTK630){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(VTK630, VTK630)

    add_library(VTK630, vtkalglib-6)
    add_library(VTK630, vtkChartsCore-6)
    add_library(VTK630, vtkCommonColor-6)
    add_library(VTK630, vtkCommonComputationalGeometry-6)
    add_library(VTK630, vtkCommonCore-6)
    add_library(VTK630, vtkCommonDataModel-6)
    add_library(VTK630, vtkCommonExecutionModel-6)
    add_library(VTK630, vtkCommonMath-6)
    add_library(VTK630, vtkCommonMisc-6)
    add_library(VTK630, vtkCommonSystem-6)
    add_library(VTK630, vtkCommonTransforms-6)
    add_library(VTK630, vtkDICOMParser-6)
    add_library(VTK630, vtkDomainsChemistry-6)
    add_library(VTK630, vtkexoIIc-6)
    add_library(VTK630, vtkexpat-6)
    add_library(VTK630, vtkFiltersAMR-6)
    add_library(VTK630, vtkFiltersCore-6)
    add_library(VTK630, vtkFiltersExtraction-6)
    add_library(VTK630, vtkFiltersFlowPaths-6)
    add_library(VTK630, vtkFiltersGeneral-6)
    add_library(VTK630, vtkFiltersGeneric-6)
    add_library(VTK630, vtkFiltersGeometry-6)
    add_library(VTK630, vtkFiltersHybrid-6)
    add_library(VTK630, vtkFiltersHyperTree-6)
    add_library(VTK630, vtkFiltersImaging-6)
    add_library(VTK630, vtkFiltersModeling-6)
    add_library(VTK630, vtkFiltersParallel-6)
    add_library(VTK630, vtkFiltersParallelImaging-6)
    add_library(VTK630, vtkFiltersProgrammable-6)
    add_library(VTK630, vtkFiltersSelection-6)
    add_library(VTK630, vtkFiltersSMP-6)
    add_library(VTK630, vtkFiltersSources-6)
    add_library(VTK630, vtkFiltersStatistics-6)
    add_library(VTK630, vtkFiltersTexture-6)
    add_library(VTK630, vtkFiltersVerdict-6)
    add_library(VTK630, vtkfreetype-6)
    add_library(VTK630, vtkftgl-6)
    add_library(VTK630, vtkGeovisCore-6)
    add_library(VTK630, vtkgl2ps-6)
    add_library(VTK630, vtkhdf5-6)
    add_library(VTK630, vtkhdf5_hl-6)
    add_library(VTK630, vtkImagingColor-6)
    add_library(VTK630, vtkImagingCore-6)
    add_library(VTK630, vtkImagingFourier-6)
    add_library(VTK630, vtkImagingGeneral-6)
    add_library(VTK630, vtkImagingHybrid-6)
    add_library(VTK630, vtkImagingMath-6)
    add_library(VTK630, vtkImagingMorphological-6)
    add_library(VTK630, vtkImagingSources-6)
    add_library(VTK630, vtkImagingStatistics-6)
    add_library(VTK630, vtkImagingStencil-6)
    add_library(VTK630, vtkInfovisCore-6)
    add_library(VTK630, vtkInfovisLayout-6)
    add_library(VTK630, vtkInteractionImage-6)
    add_library(VTK630, vtkInteractionStyle-6)
    add_library(VTK630, vtkInteractionWidgets-6)
    add_library(VTK630, vtkIOAMR-6)
    add_library(VTK630, vtkIOCore-6)
    add_library(VTK630, vtkIOEnSight-6)
    add_library(VTK630, vtkIOExodus-6)
    add_library(VTK630, vtkIOExport-6)
    add_library(VTK630, vtkIOGeometry-6)
    add_library(VTK630, vtkIOImage-6)
    add_library(VTK630, vtkIOImport-6)
    add_library(VTK630, vtkIOInfovis-6)
    add_library(VTK630, vtkIOLegacy-6)
    add_library(VTK630, vtkIOLSDyna-6)
    add_library(VTK630, vtkIOMINC-6)
    add_library(VTK630, vtkIOMovie-6)
    add_library(VTK630, vtkIONetCDF-6)
    add_library(VTK630, vtkIOParallel-6)
    add_library(VTK630, vtkIOParallelXML-6)
    add_library(VTK630, vtkIOPLY-6)
    add_library(VTK630, vtkIOSQL-6)
    add_library(VTK630, vtkIOVideo-6)
    add_library(VTK630, vtkIOXML-6)
    add_library(VTK630, vtkIOXMLParser-6)
    add_library(VTK630, vtkjpeg-6)
    add_library(VTK630, vtkjsoncpp-6)
    add_library(VTK630, vtklibxml2-6)
    add_library(VTK630, vtkmetaio-6)
    add_library(VTK630, vtkNetCDF-6)
    add_library(VTK630, vtkNetCDF_cxx-6)
    add_library(VTK630, vtkoggtheora-6)
    add_library(VTK630, vtkParallelCore-6)
    add_library(VTK630, vtkpng-6)
    add_library(VTK630, vtkproj4-6)
    add_library(VTK630, vtkRenderingAnnotation-6)
    add_library(VTK630, vtkRenderingContext2D-6)
    add_library(VTK630, vtkRenderingContextOpenGL-6)
    add_library(VTK630, vtkRenderingCore-6)
    add_library(VTK630, vtkRenderingFreeType-6)
    add_library(VTK630, vtkRenderingGL2PS-6)
    add_library(VTK630, vtkRenderingImage-6)
    add_library(VTK630, vtkRenderingLabel-6)
    add_library(VTK630, vtkRenderingLIC-6)
    add_library(VTK630, vtkRenderingLOD-6)
    add_library(VTK630, vtkRenderingOpenGL-6)
    add_library(VTK630, vtkRenderingVolume-6)
    add_library(VTK630, vtkRenderingVolumeOpenGL-6)
    add_library(VTK630, vtksqlite-6)
    add_library(VTK630, vtksys-6)
    add_library(VTK630, vtktiff-6)
    add_library(VTK630, vtkverdict-6)
    add_library(VTK630, vtkViewsContext2D-6)
    add_library(VTK630, vtkViewsCore-6)
    add_library(VTK630, vtkViewsInfovis-6)
    add_library(VTK630, vtkzlib-6)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_VTK630) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_library(VTK630, VTK630)
    #add_deploy_libraryes(VTK630)

    add_deploy_library(VTK630, vtkalglib-6)
    add_deploy_library(VTK630, vtkChartsCore-6)
    add_deploy_library(VTK630, vtkCommonColor-6)
    add_deploy_library(VTK630, vtkCommonComputationalGeometry-6)
    add_deploy_library(VTK630, vtkCommonCore-6)
    add_deploy_library(VTK630, vtkCommonDataModel-6)
    add_deploy_library(VTK630, vtkCommonExecutionModel-6)
    add_deploy_library(VTK630, vtkCommonMath-6)
    add_deploy_library(VTK630, vtkCommonMisc-6)
    add_deploy_library(VTK630, vtkCommonSystem-6)
    add_deploy_library(VTK630, vtkCommonTransforms-6)
    add_deploy_library(VTK630, vtkDICOMParser-6)
    add_deploy_library(VTK630, vtkDomainsChemistry-6)
    add_deploy_library(VTK630, vtkexoIIc-6)
    add_deploy_library(VTK630, vtkexpat-6)
    add_deploy_library(VTK630, vtkFiltersAMR-6)
    add_deploy_library(VTK630, vtkFiltersCore-6)
    add_deploy_library(VTK630, vtkFiltersExtraction-6)
    add_deploy_library(VTK630, vtkFiltersFlowPaths-6)
    add_deploy_library(VTK630, vtkFiltersGeneral-6)
    add_deploy_library(VTK630, vtkFiltersGeneric-6)
    add_deploy_library(VTK630, vtkFiltersGeometry-6)
    add_deploy_library(VTK630, vtkFiltersHybrid-6)
    add_deploy_library(VTK630, vtkFiltersHyperTree-6)
    add_deploy_library(VTK630, vtkFiltersImaging-6)
    add_deploy_library(VTK630, vtkFiltersModeling-6)
    add_deploy_library(VTK630, vtkFiltersParallel-6)
    add_deploy_library(VTK630, vtkFiltersParallelImaging-6)
    add_deploy_library(VTK630, vtkFiltersProgrammable-6)
    add_deploy_library(VTK630, vtkFiltersSelection-6)
    add_deploy_library(VTK630, vtkFiltersSMP-6)
    add_deploy_library(VTK630, vtkFiltersSources-6)
    add_deploy_library(VTK630, vtkFiltersStatistics-6)
    add_deploy_library(VTK630, vtkFiltersTexture-6)
    add_deploy_library(VTK630, vtkFiltersVerdict-6)
    add_deploy_library(VTK630, vtkfreetype-6)
    add_deploy_library(VTK630, vtkftgl-6)
    add_deploy_library(VTK630, vtkGeovisCore-6)
    add_deploy_library(VTK630, vtkgl2ps-6)
    add_deploy_library(VTK630, vtkhdf5-6)
    add_deploy_library(VTK630, vtkhdf5_hl-6)
    add_deploy_library(VTK630, vtkImagingColor-6)
    add_deploy_library(VTK630, vtkImagingCore-6)
    add_deploy_library(VTK630, vtkImagingFourier-6)
    add_deploy_library(VTK630, vtkImagingGeneral-6)
    add_deploy_library(VTK630, vtkImagingHybrid-6)
    add_deploy_library(VTK630, vtkImagingMath-6)
    add_deploy_library(VTK630, vtkImagingMorphological-6)
    add_deploy_library(VTK630, vtkImagingSources-6)
    add_deploy_library(VTK630, vtkImagingStatistics-6)
    add_deploy_library(VTK630, vtkImagingStencil-6)
    add_deploy_library(VTK630, vtkInfovisCore-6)
    add_deploy_library(VTK630, vtkInfovisLayout-6)
    add_deploy_library(VTK630, vtkInteractionImage-6)
    add_deploy_library(VTK630, vtkInteractionStyle-6)
    add_deploy_library(VTK630, vtkInteractionWidgets-6)
    add_deploy_library(VTK630, vtkIOAMR-6)
    add_deploy_library(VTK630, vtkIOCore-6)
    add_deploy_library(VTK630, vtkIOEnSight-6)
    add_deploy_library(VTK630, vtkIOExodus-6)
    add_deploy_library(VTK630, vtkIOExport-6)
    add_deploy_library(VTK630, vtkIOGeometry-6)
    add_deploy_library(VTK630, vtkIOImage-6)
    add_deploy_library(VTK630, vtkIOImport-6)
    add_deploy_library(VTK630, vtkIOInfovis-6)
    add_deploy_library(VTK630, vtkIOLegacy-6)
    add_deploy_library(VTK630, vtkIOLSDyna-6)
    add_deploy_library(VTK630, vtkIOMINC-6)
    add_deploy_library(VTK630, vtkIOMovie-6)
    add_deploy_library(VTK630, vtkIONetCDF-6)
    add_deploy_library(VTK630, vtkIOParallel-6)
    add_deploy_library(VTK630, vtkIOParallelXML-6)
    add_deploy_library(VTK630, vtkIOPLY-6)
    add_deploy_library(VTK630, vtkIOSQL-6)
    add_deploy_library(VTK630, vtkIOVideo-6)
    add_deploy_library(VTK630, vtkIOXML-6)
    add_deploy_library(VTK630, vtkIOXMLParser-6)
    add_deploy_library(VTK630, vtkjpeg-6)
    add_deploy_library(VTK630, vtkjsoncpp-6)
    add_deploy_library(VTK630, vtklibxml2-6)
    add_deploy_library(VTK630, vtkmetaio-6)
    add_deploy_library(VTK630, vtkNetCDF-6)
    add_deploy_library(VTK630, vtkNetCDF_cxx-6)
    add_deploy_library(VTK630, vtkoggtheora-6)
    add_deploy_library(VTK630, vtkParallelCore-6)
    add_deploy_library(VTK630, vtkpng-6)
    add_deploy_library(VTK630, vtkproj4-6)
    add_deploy_library(VTK630, vtkRenderingAnnotation-6)
    add_deploy_library(VTK630, vtkRenderingContext2D-6)
    add_deploy_library(VTK630, vtkRenderingContextOpenGL-6)
    add_deploy_library(VTK630, vtkRenderingCore-6)
    add_deploy_library(VTK630, vtkRenderingFreeType-6)
    add_deploy_library(VTK630, vtkRenderingGL2PS-6)
    add_deploy_library(VTK630, vtkRenderingImage-6)
    add_deploy_library(VTK630, vtkRenderingLabel-6)
    add_deploy_library(VTK630, vtkRenderingLIC-6)
    add_deploy_library(VTK630, vtkRenderingLOD-6)
    add_deploy_library(VTK630, vtkRenderingOpenGL-6)
    add_deploy_library(VTK630, vtkRenderingVolume-6)
    add_deploy_library(VTK630, vtkRenderingVolumeOpenGL-6)
    add_deploy_library(VTK630, vtksqlite-6)
    add_deploy_library(VTK630, vtksys-6)
    add_deploy_library(VTK630, vtktiff-6)
    add_deploy_library(VTK630, vtkverdict-6)
    add_deploy_library(VTK630, vtkViewsContext2D-6)
    add_deploy_library(VTK630, vtkViewsCore-6)
    add_deploy_library(VTK630, vtkViewsInfovis-6)
    add_deploy_library(VTK630, vtkzlib-6)

    return (1)
}
