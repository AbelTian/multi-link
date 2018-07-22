#include "mainwindow.h"
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

    ui->checkBox->setChecked ( true );

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
    ui->comboBox->addItem ( "Armhf32" );
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

    connect ( ui->lineEdit_2, SIGNAL ( textChanged ( QString ) ), this, SLOT ( textChanged ( QString ) ) );
    connect ( ui->lineEdit, SIGNAL ( textChanged ( QString ) ), this, SLOT ( sdkRootChanged ( QString ) ) );

    QFile f ( "add_library_Template.pri" );
    f.open ( QFile::ReadOnly );
    fileBytes = f.readAll();
    f.close();

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

    //clickBtn();
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

void MainWindow::textChanged ( QString str )
{
    ui->tabWidget->setTabText ( 3, QString ( "add_library_%1.pri" ).arg ( str ) );
}

void MainWindow::sdkRootChanged ( QString str )
{
    QString path = str + "/app-lib";
#ifdef Q_OS_WIN
    path.replace ( "/", "\\" );
#endif
    ui->lineEdit_3->setText ( path );
}

void MainWindow::on_pushButton_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    if ( ui->lineEdit_2->text().isEmpty() )
        return;

    ui->statusBar->showMessage ( "processing...." );

    ui->textBrowser->clear();
    ui->textBrowser_2->clear();
    ui->textBrowser_3->clear();

    QString header = ui->lineEdit->text() + "/" + ui->lineEdit_2->text() + "/" + ui->comboBox->currentText() + "/include";
    QString lib = ui->lineEdit->text() + "/" + ui->lineEdit_2->text() + "/" + ui->comboBox->currentText() + "/lib";

    QQtDictionary headerDict;
    QQtDictionary libDict;

    QString bundle = "";
    if ( ui->checkBox->isChecked() )
        bundle = "_bundle";

    QDir d ( header );
    //遍历头文件
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
            //subdir name
            //其实，这个空判断只有在有一个模块的时候才有点作用，在多个模块的时候，这个空判断是没有用的。
            //这个空判断的目的，是如果用户手动调用add_include_XXX(path)，qmake会到path指定路径去找一系列的头文件，自定义用的。
            //但是通常状况下，都是去SDK标准目录下寻找，所以这个空判断显得，没什么用。
            //根据multi-link的设计，这个路径的空判断毫无作用，但是功能保留下来。
            ui->textBrowser->append ( "" );//blank line 第一行会为空？不知为何。
            ui->textBrowser->append ( "#header_path = $$1" );//tip
            ui->textBrowser->append ( QString ( "isEmpty(1):header_path=$$get_add_include%1(%2, %3)" )
                                      .arg ( bundle )
                                      .arg ( ui->lineEdit_2->text() )
                                      .arg ( mfi.baseName() ) );
            ui->textBrowser->append ( "command += $${header_path}" );
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


    enum
    {
        SUFFIX_LA = 1,
        SUFFIX_DLL_A,
        SUFFIX_A,
        SUFFIX_LIB,     //LIB DYLIB
        SUFFIX_SO,      //.SO .X.X.SO .SO.X.X.X
        SUFFIX_DLL,

        SUFFIX_MAX
    };

    QDir d2 ( lib );
    int use_suffix = 0;
    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.dll
            if ( mfi.suffix() == "dll" )
            {
                use_suffix = SUFFIX_DLL;
            }
        }
    }


    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.so .so.1 .so.1.2  +.so.1.2.3
            if ( mfi.suffix() == "so"  )
            {
                use_suffix = SUFFIX_SO;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.dylib .lib
            if ( mfi.suffix().contains ( "lib" ) )
            {
                use_suffix = SUFFIX_LIB;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.a
            if ( mfi.completeSuffix() == "a" )
            {
                use_suffix = SUFFIX_A;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.dll.a
            if ( mfi.completeSuffix().right ( 5 ) == "dll.a"  )
            {
                use_suffix = SUFFIX_DLL_A;
            }
        }
    }

    foreach ( QFileInfo mfi, d2.entryInfoList() )
    {
        if ( mfi.isFile() )
        {
            //.la
            if ( mfi.suffix() == "la" )
            {
                use_suffix = SUFFIX_LA;
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
            switch ( use_suffix )
            {
                case SUFFIX_LA:
                {
                    if ( mfi.suffix() != "la"  )
                        continue;
                }
                break;
                case SUFFIX_A:
                {
                    if ( mfi.completeSuffix().contains ( "dll.a" )  )
                        continue;

                    if ( mfi.suffix() != "a"  )
                        continue;
                }
                break;
                case SUFFIX_DLL_A:
                {
                    if ( mfi.completeSuffix().right ( 5 ) != "dll.a" )
                        continue;
                }
                break;
                case SUFFIX_LIB:
                {
                    if ( !mfi.suffix().contains ( "lib" ) )
                        continue;
                }
                break;
                case SUFFIX_SO:
                {
                    if ( mfi.suffix() != "so"  )
                        continue;
                }
                break;
                case SUFFIX_DLL:
                {
                    if ( mfi.suffix() != "dll"  )
                        continue;
                }
                break;
                default:
                    continue;
                    break;
            }

            QString name = mfi.completeBaseName();
            if ( use_suffix == SUFFIX_DLL_A )
                name = name.remove ( name.size() - 4, 4 );

            if ( name.startsWith ( "lib" ) )
                name.remove ( 0, 3 );
            pline() << name;

            //if ( ui->textBrowser_2->toPlainText().contains ( name ) )
            //    continue;

            if ( libList.contains ( name ) )
                continue;

            QString tempname = name;
            if ( tempname.endsWith ( "-d" ) )
                tempname.remove ( tempname.size() - 2, 2 );
            if ( tempname.endsWith ( "d" ) )
                tempname.remove ( tempname.size() - 1, 1 );
            if ( tempname.endsWith ( "_debug" ) )
                tempname.remove ( tempname.size() - 6, 6 );

            if ( libList.contains ( tempname ) )
                continue;

            libList.push_back ( tempname );

            QString lib_path = QString ( "add_library%1(%2, %3)" )
                               .arg ( bundle )
                               .arg ( ui->lineEdit_2->text() )
                               .arg ( tempname );
            ui->textBrowser_2->append ( lib_path );

            QString lib_deploy_path = QString ( "add_deploy_library%1(%2, %3)" )
                                      .arg ( bundle )
                                      .arg ( ui->lineEdit_2->text() )
                                      .arg ( tempname );
            ui->textBrowser_3->append ( lib_deploy_path );
        }
    }

    ui->textBrowser_4->clear();

    QByteArray fBytes = fileBytes;
    fBytes.replace ( "Template", ui->lineEdit_2->text().toLocal8Bit() );

    QString addIncStr = ui->textBrowser->toPlainText();
    QString addLibStr = ui->textBrowser_2->toPlainText();
    QString addDeployLibStr = ui->textBrowser_3->toPlainText();

    QStringList addIncList = addIncStr.split ( '\n' );
    QStringList addLibList = addLibStr.split ( '\n' );
    QStringList addDeployLibList = addDeployLibStr.split ( '\n' );

    pline() << addIncList.size() << addLibList.size() << addDeployLibList.size();

    QString sep1 = "#...";
    QString sep2 = QString ( "add_library(%1, %1)" ).arg ( ui->lineEdit_2->text() );
    QString sep3 = QString ( "add_deploy_library(%1, %1)" ).arg ( ui->lineEdit_2->text() );

    QBuffer buf ( &fBytes );
    buf.open ( QBuffer::ReadOnly );

    while ( !buf.atEnd() )
    {
        QByteArray line = buf.readLine();
        if ( line.endsWith ( '\n' ) )
            line.remove ( line.size() - 1, 1 );
        if ( line.endsWith ( '\r' ) )
        {
            pline() << "这个会不会发生？";
            line.remove ( line.size() - 1, 1 );
        }

        ui->textBrowser_4->append ( line );

        if ( line.contains ( sep1.toLocal8Bit() ) )
        {
            //include
            QStringListIterator itor ( addIncList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                ui->textBrowser_4->append ( "    " + str );
            }
        }
        else if ( line.contains ( sep2.toLocal8Bit() ) )
        {
            //library
            QStringListIterator itor ( addLibList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                ui->textBrowser_4->append ( "    " + str );
            }
        }
        else if ( line.contains ( sep3.toLocal8Bit() ) )
        {
            //deploy library
            QStringListIterator itor ( addDeployLibList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                ui->textBrowser_4->append ( "    " + str );
            }
        }
    }

    buf.close();

    ui->statusBar->showMessage ( "Successed." );

    return;
}

void MainWindow::on_pushButton_2_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    if ( ui->lineEdit_2->text().isEmpty() )
        return;

    if ( ui->lineEdit_3->text().isEmpty() )
        return;

    QString sep = "/";
#ifdef Q_OS_WIN
    sep = "\\";
#endif
    QString filename = ui->lineEdit_3->text() + sep + ui->tabWidget->tabBar()->tabText ( 3 );
    pline() << filename;
    QFile file ( filename );
    file.open ( QFile::Truncate | QFile::WriteOnly );
    QString content = ui->textBrowser_4->toPlainText();
    file.write ( content.toLocal8Bit() );
    file.close();
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
                pline() << e->modifiers();
                pline() <<  ( e->modifiers() | Qt::ControlModifier );
                pline() << ( e->modifiers() & Qt::ControlModifier );

                if ( ( e->modifiers() & Qt::ControlModifier ) != Qt::ControlModifier )
                    break;

                int i = ui->tabWidget->currentIndex();
                if ( i == 0 )
                    i = ui->tabWidget->count();
                i = ( i - 1 ) % ui->tabWidget->count();
                ui->tabWidget->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Right:
            {
                if ( ( e->modifiers() & Qt::ControlModifier ) != Qt::ControlModifier )
                    break;

                int i = ui->tabWidget->currentIndex();
                i = ( i + 1 ) % ui->tabWidget->count();
                ui->tabWidget->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Up:
            {
                int i = ui->comboBox->currentIndex();
                if ( i == 0 )
                    i = ui->comboBox->count();
                i = ( i - 1 ) % ui->comboBox->count();
                ui->comboBox->setCurrentIndex ( i );
                e->accept();
                return true;
            }
            break;
            case Qt::Key_Down:
            {
                int i = ui->comboBox->currentIndex();
                i = ( i + 1 ) % ui->comboBox->count();
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
            int i = ui->comboBox->currentIndex();
            if ( i == 0 )
                i = ui->comboBox->count();
            i = ( i - 1 ) % ui->comboBox->count();
            ui->comboBox->setCurrentIndex ( i );
            e->accept();
            return true;
        }
        else
        {
            int i = ui->comboBox->currentIndex();
            i = ( i + 1 ) % ui->comboBox->count();
            ui->comboBox->setCurrentIndex ( i );
            e->accept();
            return true;
        }
    }

    return QMainWindow::eventFilter ( watched, event );
}

