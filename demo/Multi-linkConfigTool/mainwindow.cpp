#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDir>
#include <QFile>

#if QT_VERSION >= QT_VERSION_CHECK(5,0,0)
#include <QStandardPaths>
#else
#include <QDesktopServices>
#endif

MainWindow::MainWindow ( QWidget* parent ) :
    QMainWindow ( parent ),
    ui ( new Ui::MainWindow )
{
    ui->setupUi ( this );

    QString homepath;
#if QT_VERSION >= QT_VERSION_CHECK(5,0,0)
    homepath = QStandardPaths::writableLocation ( QStandardPaths::HomeLocation );;
#else
    homepath = QDesktopServices::storageLocation ( QDesktopServices::HomeLocation );
#endif
    homepath = QDir::homePath();

    QString filename = homepath + "/.qmake/app_configure.pri";
    QFile file ( filename );
    file.open ( QFile::ReadOnly );
    QByteArray bytes = file.readAll();
    file.close();

    QString deployroot;
    QString sdkroot;
    QString buildroot;

    QString str = bytes;
    QStringList sss = str.split ( '\n' );
    QStringListIterator itor ( sss );
    while ( itor.hasNext() )
    {
        QString s = itor.next();
        if ( s.contains ( "APP_DEPLOY_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            deployroot = s0;
        }
        if ( s.contains ( "LIB_SDK_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            sdkroot = s0;
        }
        if ( s.contains ( "APP_BUILD_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            buildroot = s0;
        }
    }

    ui->lineEdit->setText ( deployroot );
    ui->lineEdit_2->setText ( sdkroot );
    ui->lineEdit_3->setText ( buildroot );

    setMinimumSize ( 600, 220 );
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QString homepath;
#if QT_VERSION >= QT_VERSION_CHECK(5,0,0)
    homepath = QStandardPaths::writableLocation ( QStandardPaths::HomeLocation );;
#else
    homepath = QDesktopServices::storageLocation ( QDesktopServices::HomeLocation );
#endif
    homepath = QDir::homePath();

    QDir().mkdir ( homepath + "/.qmake" );

    QString filename = homepath + "/.qmake/app_configure.pri";
    QFile file ( filename );
    file.open ( QFile::Truncate | QFile::WriteOnly );
    QString deployroot;
    QString sdkroot;
    QString buildroot;
    deployroot = QString ( "APP_DEPLOY_ROOT=%1\n" ).arg ( ui->lineEdit->text() );
    sdkroot = QString ( "LIB_SDK_ROOT=%1\n" ).arg ( ui->lineEdit_2->text() );
    buildroot = QString ( "APP_BUILD_ROOT=%1\n" ).arg ( ui->lineEdit_3->text() );
    file.write ( deployroot.toLocal8Bit() );
    file.write ( sdkroot.toLocal8Bit() );
    file.write ( buildroot.toLocal8Bit() );
    file.close();
}
