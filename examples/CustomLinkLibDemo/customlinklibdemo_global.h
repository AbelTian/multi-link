#ifndef CUSTOMLINKLIBDEMO_GLOBAL_H
#define CUSTOMLINKLIBDEMO_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(CUSTOMLINKLIBDEMO_LIBRARY)
#  define CUSTOMLINKLIBDEMOSHARED_EXPORT Q_DECL_EXPORT
#else
#  define CUSTOMLINKLIBDEMOSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // CUSTOMLINKLIBDEMO_GLOBAL_H
