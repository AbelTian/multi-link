#---------------------------------------------------------------------------------
#add_icons.pri
#为App添加Icons。(app only)
#用户在固定目录准备好图片就行了。
#---------------------------------------------------------------------------------
#add_icons()

#在logo目录
#Windows 建议使用PixelFormer使用logo.png制作logo.ico，放置其中。
#macOS 创建logo.iconset文件夹 放置所有的png图标 函数会自动生成logo.icns
#Linux ？

#add_icons函数会从logo文件夹里加载图标。用户需要在logo文件夹下准备好必要的资源。
#路径里不要有空格
defineTest(add_icons){
    #调用处$${PWD}，不是这个pri的位置。
    !exists("$${PWD}/logo"):mkdir("$${PWD}/logo")
    contains(DEFINES, __WIN__){
        #win32 win64 msvc msvc64 winrt?
        filepath = $${PWD}/logo/logo.rc
        contains(QMAKE_HOST.os, Windows){
            filepath~=s,/,\\,g
        }
        ret = $$system(echo IDI_ICON1    ICON    DISCARDABLE    \"logo.ico\" > "$${filepath}")
        RC_FILE += "$${filepath}"
        export(RC_FILE)
    } else : contains(DEFINES, __DARWIN__) {
        #macOS
        !exists("$${PWD}/logo/logo.iconset"):mkdir("$${PWD}/logo/logo.iconset")
        filepath = $${PWD}/logo/logo.icns
        ret = $$system(iconutil -c icns -o $${filepath} $${PWD}/logo/logo.iconset)
        ICON += "$${filepath}"
        export(ICON)
    } else : contains(DEFINES, __LINUX__)  {
        #linux linux64 embedded?
    }
    #android是通过AndroidManifast.xml指定的。
    return (1)
}
