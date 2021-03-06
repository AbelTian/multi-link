#ifndef LINKDYNAMICLIBTEST_GLOBAL_H
#define LINKDYNAMICLIBTEST_GLOBAL_H

#include <QtCore/qglobal.h>

#ifdef Q_OS_WIN
#if defined(LINKDYNAMICLIBTEST_LIBRARY)
#  define LINKDYNAMICLIBTESTSHARED_EXPORT Q_DECL_EXPORT
#elif defined(LINKDYNAMICLIBTEST_STATIC_LIBRARY)
#  define LINKDYNAMICLIBTESTSHARED_EXPORT
#else
#  define LINKDYNAMICLIBTESTSHARED_EXPORT Q_DECL_IMPORT
#endif
#else
#  define LINKDYNAMICLIBTESTSHARED_EXPORT
#endif

#endif // LINKDYNAMICLIBTEST_GLOBAL_H
