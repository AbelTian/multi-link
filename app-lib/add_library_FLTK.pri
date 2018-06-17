#----------------------------------------------------------------
#add_library_FLTK.pri
#���Ǹ��û��ṩ�ķ���pri
#����Ƚ�common�����������û������и��ġ�
#----------------------------------------------------------------
#_bundle��ȡ�ᣬ����macOSϵͳ�£�ʹ�õ�libraryΪbundle��ʽ������dylib��ʽ��

#######################################################################################
#��ʼ������
#######################################################################################


#######################################################################################
#���庯��
#######################################################################################
#�޸�
defineTest(add_include_FLTK){
    #��Ϊ�գ��϶���Դ�����·���� ���ڵ���ͷ�ļ�
    header_path = $$1
    #�������1Ϊ�գ���ô����SDK���·�� ��������ʱ����ͷ�ļ�
    #�˴�_bundle���� mac��ͷ�ļ���bundle� ����
    isEmpty(header_path)header_path=$$get_add_include(FLTK, FLTK)

    command =
    #basic
    command += $${header_path}
    #�������$${path}�µ����ļ���
    #...
    command += $${header_path}/images

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#�޸�
defineTest(add_defines_FLTK){
    #������SDK���defines
    #add_defines()

    return (1)
}

#�޸�
defineTest(add_library_FLTK){
    #����ط�add_library_bundle���� macOS�£�lib��bundle� ����
    #������SDK���library
    #add_library(FLTK, FLTK)
    add_library(FLTK, fltk)
    add_library(FLTK, fltk_forms)
    add_library(FLTK, fltk_gl)
    add_library(FLTK, fltk_images)
    add_library(FLTK, fltk_jpeg)
    add_library(FLTK, fltk_png)
    add_library(FLTK, fltk_z)

    return (1)
}


#��������library
#ע��AndroidҲ��Ҫ���������ʹ���������Android�Żᷢ��Library������ʱ���ϱߵ�ֻ���������á�
#�޸�
defineTest(add_deploy_library_FLTK) {
    #����ط�add_deploy_library_bundle����macOS�·�������bundle��ʽ��
    #add_deploy_library(FLTK, FLTK)
    #add_deploy_libraryes(FLTK)
    add_deploy_library(FLTK, fltk)
    add_deploy_library(FLTK, fltk_forms)
    add_deploy_library(FLTK, fltk_gl)
    add_deploy_library(FLTK, fltk_images)
    add_deploy_library(FLTK, fltk_jpeg)
    add_deploy_library(FLTK, fltk_png)
    add_deploy_library(FLTK, fltk_z)

    return (1)
}