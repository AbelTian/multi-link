TEMPLATE = subdirs
CONFIG += ordered

########################################################################################
#macOS Windows linux

########################################################################################
#test project
SUBDIRS += test/AddDynamicLibTest
SUBDIRS += test/LinkDynamicLibTest
SUBDIRS += test/LinkDynamicLibTest2

SUBDIRS += test/AddDynamicLibTest2
SUBDIRS += test/LinkDynamicLibTest3
SUBDIRS += test/LinkDynamicLibTest4

SUBDIRS += test/AddStaticLibTest
SUBDIRS += test/LinkStaticLibTest

#SUBDIRS += test/nonQtProjTest
SUBDIRS += test/AddLibPriTest
SUBDIRS += test/AddAppIconTest

