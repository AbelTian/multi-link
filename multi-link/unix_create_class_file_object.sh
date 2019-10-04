#!/usr/bin/env bash

while [ 1 ]
do

CLASSNAME=$1
BIGNAME=$(echo $CLASSNAME | tr '[a-z]' '[A-Z]')
FILENAME=$(echo $CLASSNAME | tr '[A-Z]' '[a-z]')
if [ "$CLASSNAME" = "" ]; then
    break
fi

FILEPATH=$2
if [ "$FILEPATH" = "" ]; then
    FILEPATH=$(pwd)
fi

#echo $CLASSNAME
#echo $BIGNAME
#echo $FILENAME
#echo $FILEPATH

FILEHPP=${FILEPATH}/${FILENAME}.h
FILECPP=${FILEPATH}/${FILENAME}.cpp
if [ -f $FILEHPP ]; then
    #test
    break
fi
if [ -f $FILECPP ]; then
    #test
    break
fi
echo $FILEHPP
echo $FILECPP

echo 2> ${FILECPP}
echo 2> ${FILEHPP}

#cpp
echo \#include \<${FILENAME}.h\> >> ${FILECPP}
echo >> ${FILECPP}

#hpp
echo \#ifndef ${BIGNAME}_H >> ${FILEHPP}
echo \#define ${BIGNAME}_H >> ${FILEHPP}
echo >> ${FILEHPP}
echo \#include \<QObject\> >> ${FILEHPP}
echo >> ${FILEHPP}
echo class ${CLASSNAME} : public QObject >> ${FILEHPP}
echo { >> ${FILEHPP}
echo \ \ \ \ Q_OBJECT >> ${FILEHPP}
echo >> ${FILEHPP}
echo public: >> ${FILEHPP}
echo \ \ \ \ explicit ${CLASSNAME} \( QObject* parent = 0 \) : QObject \( parent \) {} >> ${FILEHPP}
echo \ \ \ \ virtual ~${CLASSNAME}\(\) {} >> ${FILEHPP}
echo >> ${FILEHPP}
echo protected: >> ${FILEHPP}
echo >> ${FILEHPP}
echo private: >> ${FILEHPP}
echo >> ${FILEHPP}
echo }\; >> ${FILEHPP}
echo >> ${FILEHPP}
echo \#endif // ${BIGNAME}_H >> ${FILEHPP}
echo >> ${FILEHPP}

break
done
