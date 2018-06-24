#include "mainwindow.h"
#include <QApplication>
#include <QTextCodec>

int main ( int argc, char* argv[] )
{
    QApplication a ( argc, argv );

#if QT_VERSION < QT_VERSION_CHECK(5,0,0)
    QTextCodec::setCodecForTr ( QTextCodec::codecForName ( "UTF-8" ) );
    QTextCodec::setCodecForCStrings ( QTextCodec::codecForName ( "UTF-8" ) );
#endif
    QTextCodec::setCodecForLocale ( QTextCodec::codecForName ( "UTF-8" ) );

    MainWindow w;
    w.show();

    return a.exec();
}
