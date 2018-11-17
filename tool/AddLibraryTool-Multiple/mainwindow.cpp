#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "qqtcore.h"
#include "qqtframe.h"
#include "qqtversion.h"
#include <QStringList>
#include <QStringListIterator>
#include <qqtdictionary.h>
#include <QTextBrowser>

MainWindow::MainWindow ( QWidget* parent ) :
    QMainWindow ( parent ),
    ui ( new Ui::MainWindow )
{
    ui->setupUi ( this );

    setMinimumSize ( 1024, 600 );

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


    ui->lineEdit_3->installEventFilter ( this );

    ui->listWidget->setFixedWidth ( 200 );
    ui->listWidget->setWindowTitle ( "Sdk List" );

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

    ui->label->setBuddy ( ui->lineEdit );
    connect ( ui->lineEdit, SIGNAL ( textChanged ( QString ) ), this, SLOT ( textChanged ( QString ) ) );
    ui->lineEdit->setText ( deployroot );

    connect ( this, SIGNAL ( clickBtn() ), this, SLOT ( on_pushButton_clicked() ), Qt::QueuedConnection );
    clickBtn();
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::textChanged ( QString str )
{
    ui->lineEdit_2->setText ( QString ( "%1/app-lib" ).arg ( str ) );
}

void MainWindow::on_pushButton_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    ui->statusBar->showMessage ( "refresh processing...." );

    ui->listWidget->clear();

    int row = 0;
    QDir d ( ui->lineEdit->text() );
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

            //如果直接使用，却不new item，会崩溃退出。
            //虽然设置了count，但是里面没有item。
            //ui->tableWidget->item ( row, 0 )->setText ( mfi.fileName() );

            QListWidgetItem* item = new QListWidgetItem ( mfi.fileName() );
            item->setFlags ( item->flags() | Qt::ItemIsUserCheckable );
            item->setCheckState ( Qt::Unchecked );
            ui->listWidget->addItem ( item );
            row++;
        }
    }


    ui->statusBar->showMessage ( "Refresh Successed." );
    return;
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

void MainWindow::outputWrokflow ( QString sdkName )
{
    QTextBrowser* textAddInclude = 0;
    QTextBrowser* textAddLibrary = 0;
    QTextBrowser* textAddDeployLibrary = 0;
    QTextBrowser* textAddLibraryPri = 0;
    if ( textAddInclude == 0 )
    {
        textAddInclude = new QTextBrowser ( this );
        textAddLibrary = new QTextBrowser ( this );
        textAddDeployLibrary = new QTextBrowser ( this );
        textAddLibraryPri = new QTextBrowser ( this );
    }

    textAddInclude->clear();
    textAddLibrary->clear();
    textAddDeployLibrary->clear();
    textAddLibraryPri->clear();

    QString header = ui->lineEdit->text() + "/" + sdkName + "/" + ui->comboBox->currentText() + "/include";
    QString lib = ui->lineEdit->text() + "/" + sdkName + "/" + ui->comboBox->currentText() + "/lib";

    QQtDictionary headerDict;
    QQtDictionary libDict;

    QString bundle = "";
    if ( ui->checkBox->isChecked() )
        bundle = "_bundle";

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
            //subdir name
            textAddInclude->append ( "" );//blank line
            //textAddInclude->append ( "#header_path = $$1" );
            textAddInclude->append ( QString ( "header_path=$$get_add_include%1(%2, %3)" )
                                     .arg ( bundle )
                                     .arg ( sdkName )
                                     .arg ( mfi.baseName() ) );
            textAddInclude->append ( "command += $${header_path}" );
            QQtDictionaryListIterator itor ( headerDict[mfi.baseName()]["childen"].getList() );
            while ( itor.hasNext() )
            {
                const QQtDictionary& dict = itor.next();
                QString path = dict.getValue().toString();
                QString header_path = QString ( "command += $${header_path}/%1" ).arg ( path );
                textAddInclude->append ( header_path );
            }
            //ui->textBrowser->append ( "" );
        }
    }


    enum
    {
        SUFFIX_LA = 1,  //.LA
        SUFFIX_DLL_A,   //.DLL.A
        SUFFIX_A,       //.A
        SUFFIX_LIB,     //.LIB .DYLIB
        SUFFIX_SO,      //.SO .X.X.SO .SO.X.X.X
        SUFFIX_DLL,     //.DLL
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
                               .arg ( sdkName )
                               .arg ( tempname );
            textAddLibrary->append ( lib_path );

            QString lib_deploy_path = QString ( "add_deploy_library%1(%2, %3)" )
                                      .arg ( bundle )
                                      .arg ( sdkName )
                                      .arg ( tempname );
            textAddDeployLibrary->append ( lib_deploy_path );
        }
    }

    QByteArray fBytes = fileBytes;
    fBytes.replace ( "Template", sdkName.toLocal8Bit() );
    fBytes.replace ( "template", sdkName.toLower().toLocal8Bit() );
    fBytes.replace ( "TEMPLATE", sdkName.toUpper().toLocal8Bit() );

    QString addIncStr = textAddInclude->toPlainText();
    QString addLibStr = textAddLibrary->toPlainText();
    QString addDeployLibStr = textAddDeployLibrary->toPlainText();

    QStringList addIncList = addIncStr.split ( '\n' );
    QStringList addLibList = addLibStr.split ( '\n' );
    QStringList addDeployLibList = addDeployLibStr.split ( '\n' );

    pline() << addIncList.size() << addLibList.size() << addDeployLibList.size();

    QString sep1 = "#...";
    QString sep2 = QString ( "add_library(%1, %1)" ).arg ( sdkName );
    QString sep3 = QString ( "add_deploy_library(%1, %1)" ).arg ( sdkName );

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

        textAddLibraryPri->append ( line );

        if ( line.contains ( sep1.toLocal8Bit() ) )
        {
            //include
            QStringListIterator itor ( addIncList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                textAddLibraryPri->append ( "    " + str );
            }
        }
        else if ( line.contains ( sep2.toLocal8Bit() ) )
        {
            //library
            QStringListIterator itor ( addLibList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                textAddLibraryPri->append ( "    " + str );
            }
        }
        else if ( line.contains ( sep3.toLocal8Bit() ) )
        {
            //deploy library
            QStringListIterator itor ( addDeployLibList );
            while ( itor.hasNext() )
            {
                QString str = itor.next();
                textAddLibraryPri->append ( "    " + str );
            }
        }
    }

    buf.close();

    //注意不能循环创建。
    QDir ( qApp->applicationDirPath() ).mkdir ( ui->lineEdit_2->text() );

    QString filename = ui->lineEdit_2->text() + "/" + QString ( "add_library_%1.pri" ).arg ( sdkName );
#ifdef Q_OS_WIN
    filename.replace ( "/", "\\" );
#endif
    pline() << filename;
    QFile file ( filename );
    file.open ( QFile::Truncate | QFile::WriteOnly );
    QString content = textAddLibraryPri->toPlainText();
    file.write ( content.toLocal8Bit() );
    file.close();
}

void MainWindow::on_pushButton_2_clicked()
{

    if ( ui->lineEdit->text().isEmpty() )
        return;

    if ( ui->lineEdit_2->text().isEmpty() )
        return;

    if ( ui->listWidget->count() <= 0 )
        return;

    ui->statusBar->showMessage ( "processing...." );

    ui->textBrowser->clear();
    ui->textBrowser_2->clear();
    ui->textBrowser_3->clear();

    QStringList sdkList;
    for ( int i = 0; i < ui->listWidget->count(); i++ )
    {
        if ( ui->listWidget->item ( i )->checkState() == Qt::Checked )
            sdkList.append ( ui->listWidget->item ( i )->text() );
    }

    QStringListIterator itor ( sdkList );
    while ( itor.hasNext() )
    {
        QString sdkName = itor.next();
        outputWrokflow ( sdkName );
        ui->textBrowser->append ( QString ( "add_library_%1.pri" ).arg ( sdkName ) );
        ui->textBrowser_2->append ( QString ( "add_dependent_manager(%1)" ).arg ( sdkName ) );
        ui->textBrowser_3->append ( QString ( "add_custom_dependent_manager(%1)" ).arg ( sdkName ) );
    }

    ui->statusBar->showMessage ( "Successed." );

}

bool MainWindow::eventFilter ( QObject* watched, QEvent* event )
{
    if ( event->type() == QEvent::Paint )
        return QMainWindow::eventFilter ( watched, event );

    if ( watched != ui->lineEdit_3 )
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

