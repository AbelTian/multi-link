﻿#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "qqtcore.h"
#include "qqtframe.h"
#include "qqtversion.h"
#include <QStringList>
#include <QStringListIterator>
#include <qqtdictionary.h>

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

    QString str = bytes;
    QStringList sss = str.split ( '\n' );
    QStringListIterator itor ( sss );
    while ( itor.hasNext() )
    {
        QString s = itor.next();
        if ( s.contains ( "LIB_SDK_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            deployroot = s0;
            break;
        }
    }

    ui->lineEdit->setText ( deployroot );

    ui->comboBox->addItem ( "Windows" );
    ui->comboBox->addItem ( "Win32" );
    ui->comboBox->addItem ( "Win64" );
    ui->comboBox->addItem ( "WinRT" );
    ui->comboBox->addItem ( "MSVC" );
    ui->comboBox->addItem ( "MSVC32" );
    ui->comboBox->addItem ( "MSVC64" );
    ui->comboBox->addItem ( "Linux" );
    ui->comboBox->addItem ( "Linux64" );
    ui->comboBox->addItem ( "Embedded" );
    ui->comboBox->addItem ( "Arm32" );
    ui->comboBox->addItem ( "Mips32" );
    ui->comboBox->addItem ( "Android" );
    ui->comboBox->addItem ( "macOS" );
    ui->comboBox->addItem ( "iOS" );
    ui->comboBox->addItem ( "iOSSimulator" );

    //suggest
    ui->comboBox->setCurrentIndex ( 0 );

    setMinimumSize ( 1024, 600 );

    ui->lineEdit_2->installEventFilter ( this );

    connect ( this, SIGNAL ( clickBtn() ), this, SLOT ( on_pushButton_clicked() ), Qt::QueuedConnection );

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::calculate ( QQtDictionary& dict, QString path )
{
    QDir d ( path );

    foreach ( QFileInfo mfi, d.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //qDebug() << "File :" << mfi.fileName();
        }
        else
        {
            if ( mfi.fileName() == "." || mfi.fileName() == ".." )
                continue;

            //qDebug() << "Entry Dir" << mfi.absoluteFilePath();
            //pline() << mfi.absoluteDir();
            //pline() << mfi.baseName();
            //pline() << mfi.canonicalPath();
            //pline() << mfi.completeBaseName();
            //pline() << mfi.path();
            //pline() << mfi.filePath();
            //pline() << mfi.fileName();

            //QString path = mfi.absoluteDir();
            //pline() << mfi.absoluteFilePath();
            //pline() << mfi.baseName() << mfi.fileName() << mfi.filePath();

            //dict[mfi.baseName()]["basename"] = mfi.baseName();
            //dict[mfi.baseName()]["absolutename"] = mfi.absoluteFilePath();
            //dict[mfi.baseName()]["absolutepath"] = mfi.absolutePath();
            //dict[mfi.baseName()]["relativename"] = QDir ( rootPath ).relativeFilePath ( mfi.absoluteFilePath() );

            QString path = QDir ( dict["absolutename"].getValue().toString() ).relativeFilePath ( mfi.absoluteFilePath() );
            pline() << dict["basename"].getValue().toString() << path;
            dict["childen"].addChild ( path );

            calculate ( dict, mfi.absoluteFilePath() );
        }
    }
}

void MainWindow::on_pushButton_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    if ( ui->lineEdit_2->text().isEmpty() )
        return;

    ui->textBrowser->clear();
    ui->textBrowser_2->clear();
    ui->textBrowser_3->clear();

    QString header = ui->lineEdit->text() + "/" + ui->lineEdit_2->text() + "/" + ui->comboBox->currentText() + "/include";
    QString lib = ui->lineEdit->text() + "/" + ui->lineEdit_2->text() + "/" + ui->comboBox->currentText() + "/lib";

    QQtDictionary headerDict;
    QQtDictionary libDict;

    QDir d ( header );

    foreach ( QFileInfo mfi, d.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //qDebug() << "File :" << mfi.fileName();
        }
        else
        {
            if ( mfi.fileName() == "." || mfi.fileName() == ".." )
                continue;

            //qDebug() << "Entry Dir" << mfi.absoluteFilePath();
            //pline() << mfi.absoluteDir();
            //pline() << mfi.baseName();
            //pline() << mfi.canonicalPath();
            //pline() << mfi.completeBaseName();
            //pline() << mfi.path();
            //pline() << mfi.filePath();
            //pline() << mfi.fileName();

            //QString path = mfi.absoluteDir();
            //pline() << mfi.absoluteFilePath();
            pline() << mfi.baseName() << mfi.fileName() << mfi.filePath();

            headerDict[mfi.baseName()]["basename"] = mfi.baseName();
            headerDict[mfi.baseName()]["absolutename"] = mfi.absoluteFilePath();
            headerDict[mfi.baseName()]["absolutepath"] = mfi.absolutePath();

            //深层次遍历
            calculate ( headerDict[mfi.baseName()], mfi.absoluteFilePath() );

            //遍历成功，所有的子文件夹已经深度优先遍历。
            QQtDictionaryListIterator itor ( headerDict[mfi.baseName()]["childen"].getList() );
            while ( itor.hasNext() )
            {
                const QQtDictionary& dict = itor.next();
                QString path = dict.getValue().toString();
                QString header_path = QString ( "command += $${header_path}/%1" ).arg ( path );
                ui->textBrowser->append ( header_path );
            }
            //ui->textBrowser->append ( "" );
        }
    }


    QDir d2 ( lib );
    int use_suffix = 0;
    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            if ( mfi.suffix().contains ( "dll" ) )
            {
                use_suffix = 3;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            if ( mfi.suffix().contains ( "so" ) )
            {
                use_suffix = 3;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            if ( mfi.suffix().contains ( "lib" ) )
            {
                use_suffix = 2;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            if ( mfi.suffix().contains ( "a" ) )
            {
                use_suffix = 1;
            }
        }
    }

    QList<QString> libList;

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //qDebug() << "File :" << mfi.fileName();
            pline() << mfi.baseName() << mfi.fileName() << mfi.filePath();
            libDict[mfi.baseName()]["basename"] = mfi.baseName();
            libDict[mfi.baseName()]["absolutename"] = mfi.absoluteFilePath();
            libDict[mfi.baseName()]["absolutepath"] = mfi.absolutePath();

            pline() << mfi.suffix() << mfi.completeBaseName() << mfi.completeSuffix();
            if ( use_suffix == 1 )
            {
                if ( !mfi.suffix().contains ( "a" ) )
                    continue;
            }
            else if ( use_suffix == 2 )
            {
                if ( !mfi.suffix().contains ( "lib" ) )
                    continue;
            }
            else if ( use_suffix == 3 )
            {
                if ( !mfi.suffix().contains ( "so" ) )
                    continue;
            }
            else if ( use_suffix == 4 )
            {
                if ( !mfi.suffix().contains ( "dll" ) )
                    continue;
            }

            QString name = mfi.baseName();
            if ( name.startsWith ( "lib" ) )
                name.remove ( 0, 3 );
            pline() << name;

            //if ( ui->textBrowser_2->toPlainText().contains ( name ) )
            //    continue;
            if ( libList.contains ( name ) )
                continue;
            QString tempname = name;
            if ( tempname.endsWith ( "d" ) )
                tempname.remove ( tempname.size() - 1, 1 );
            if ( tempname.endsWith ( "_debug" ) )
                tempname.remove ( tempname.size() - 6, 6 );

            if ( libList.contains ( tempname ) )
                continue;

            libList.push_back ( name );

            QString lib_path = QString ( "add_library(%1, %2)" ).arg ( ui->lineEdit_2->text() ).arg ( name );
            ui->textBrowser_2->append ( lib_path );

            QString lib_deploy_path = QString ( "add_deploy_library(%1, %2)" ).arg ( ui->lineEdit_2->text() ).arg ( name );
            ui->textBrowser_3->append ( lib_deploy_path );
        }
        else
        {
            if ( mfi.fileName() == "." || mfi.fileName() == ".." )
                continue;

            continue;
            //qDebug() << "Entry Dir" << mfi.absoluteFilePath();
            //pline() << mfi.absoluteDir();
            //pline() << mfi.baseName();
            //pline() << mfi.canonicalPath();
            //pline() << mfi.completeBaseName();
            //pline() << mfi.path();
            //pline() << mfi.filePath();
            //pline() << mfi.fileName();

            //QString path = mfi.absoluteDir();
            //pline() << mfi.absoluteFilePath();
            pline() << mfi.baseName() << mfi.fileName() << mfi.filePath();

            headerDict[mfi.baseName()]["basename"] = mfi.baseName();
            headerDict[mfi.baseName()]["absolutename"] = mfi.absoluteFilePath();
            headerDict[mfi.baseName()]["absolutepath"] = mfi.absolutePath();

            //深层次遍历
            calculate ( headerDict[mfi.baseName()], mfi.absoluteFilePath() );

            //遍历成功，所有的子文件夹已经深度优先遍历。
            QQtDictionaryListIterator itor ( headerDict[mfi.baseName()]["childen"].getList() );
            while ( itor.hasNext() )
            {
                const QQtDictionary& dict = itor.next();
                QString path = dict.getValue().toString();
                QString header_path = QString ( "command += $${header_path}/%1" ).arg ( path );
                ui->textBrowser->append ( header_path );
            }

        }
    }

    return;

#if 0
    QDir d2 ( lib );
    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //qDebug() << "File :" << mfi.fileName();
        }
        else
        {
            if ( mfi.fileName() == "." || mfi.fileName() == ".." )
                continue;

            //qDebug() << "Entry Dir" << mfi.absoluteFilePath();

            QString path = mfi.absoluteFilePath() + "/" + STR ( Q_SYS_NAME );
            QString program = path + "/";
            QString postfix;
#ifdef Q_OS_WIN
            if ( "Debug" == STR ( Q_BUILD_TYPE ) )
                postfix = "d";
            program += mfi.baseName() + postfix + ".exe";
#elif defined Q_OS_DARWIN
            if ( "Debug" == STR ( Q_BUILD_TYPE ) )
                postfix = "_debug";
            program += mfi.baseName() + postfix + ".app" + "/Contents/MacOS/" + mfi.baseName() + postfix;
#else
            program += mfi.baseName();
#endif
            pline() << program;

            //"name"
            //"path"
            QQtDictionary node;
            node["name"] = mfi.baseName();
            node["path"] = path;
            node["program"] = program;
            progList.appendChild ( node );
            progMap[mfi.baseName()]["program"] = program;
            progMap[mfi.baseName()]["name"] = mfi.baseName();
            progMap[mfi.baseName()]["path"] = path;
#ifdef Q_OS_DARWIN
            progMap[mfi.baseName()]["workpath"] = path + "/" + mfi.baseName() + postfix + ".app" + "/Contents/MacOS";
#else
            progMap[mfi.baseName()]["workpath"] = path;
#endif

        }
    }
#endif
}


bool MainWindow::eventFilter ( QObject* watched, QEvent* event )
{
    if ( event->type() == QEvent::Paint )
        return QMainWindow::eventFilter ( watched, event );

    if ( watched != ui->lineEdit_2 )
        return QMainWindow::eventFilter ( watched, event );

    if ( event->type() == QEvent::KeyRelease )
    {
        QKeyEvent* e = ( QKeyEvent* ) event;

        switch ( e->key() )
        {
            case Qt::Key_Enter:
            case Qt::Key_Return:
            {
                emit clickBtn();
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Left:
            {
                static int i = ui->tabWidget->currentIndex();
                i = qAbs ( i - 1 ) % ui->tabWidget->count();
                ui->tabWidget->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Right:
            {
                static int i = ui->tabWidget->currentIndex();
                i = qAbs ( i + 1 ) % ui->tabWidget->count();
                ui->tabWidget->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Up:
            {
                static int i = ui->comboBox->currentIndex();
                i = qAbs ( i - 1 ) % ui->comboBox->count();
                ui->comboBox->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Down:
            {
                static int i = ui->comboBox->currentIndex();
                i = qAbs ( i + 1 ) % ui->comboBox->count();
                ui->comboBox->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            default:
                break;
        }
    }

    if ( event->type() == QEvent::Wheel )
    {
        QWheelEvent* e = ( QWheelEvent* ) event;
        if ( e->delta() > 0 )
        {
            static int i = ui->comboBox->currentIndex();
            i = qAbs ( i - 1 ) % ui->comboBox->count();
            ui->comboBox->setCurrentIndex ( i );
            e->accept();
            return true;
        }
        else
        {
            static int i = ui->comboBox->currentIndex();
            i = qAbs ( i + 1 ) % ui->comboBox->count();
            ui->comboBox->setCurrentIndex ( i );
            e->accept();
            return true;
        }
    }

    return QMainWindow::eventFilter ( watched, event );
}
