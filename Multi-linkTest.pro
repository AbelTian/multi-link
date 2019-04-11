TEMPLATE = subdirs
CONFIG += ordered

########################################################################################
#macOS Windows linux

########################################################################################
#test project
SUBDIRS += test/AddDynamicLibTest
SUBDIRS += test/AddStaticLibTest
SUBDIRS += test/LinkDynamicLibTest
SUBDIRS += test/LinkStaticLibTest

#SUBDIRS += test/nonQtProjTest
SUBDIRS += test/AddLibPriTest
SUBDIRS += test/AddAppIconTest
