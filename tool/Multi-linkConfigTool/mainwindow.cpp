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

    setMinimumSize ( 600, 220 );

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
    if ( !file.isOpen() )
        return;

    fileBytes = file.readAll();
    file.close();

    QString deployroot;
    QString sdkroot;
    QString buildroot;

    QString str = fileBytes;
    QStringList sss = str.split ( '\n' );
    QStringListIterator itor ( sss );
    while ( itor.hasNext() )
    {
        QString s = itor.next();
        //以变量名开始的为对的。
        //如果=为空则忽略。
        //以最后一次遇到的有值的变量为准。
        if ( s.trimmed().startsWith ( "APP_DEPLOY_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            deployroot = s0;
        }
        if ( s.trimmed().startsWith ( "LIB_SDK_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            sdkroot = s0;
        }
        if ( s.trimmed().startsWith ( "APP_BUILD_ROOT" ) )
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

    file.write ( "\n" );
    file.write ( "#兼容Multi-link v1.0\n" );
    file.write ( "QQT_BUILD_ROOT=$${APP_BUILD_ROOT}\n" );
    file.write ( "QQT_SDK_ROOT=$${LIB_SDK_ROOT}\n" );

    file.close();
}
