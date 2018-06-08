#include "mainwindow.h"
#include <QQtApplication>

int ___main ( int argc, char* argv[] )
{
    QQtApplication a ( argc, argv );

    MainWindow w;
    w.show();

    return a.exec();
}
