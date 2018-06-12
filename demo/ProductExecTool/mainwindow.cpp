#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "qqtcore.h"
#include "qqtframe.h"
#include "qqtversion.h"
#include <QStringList>
#include <QStringListIterator>

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
        if ( s.contains ( "APP_DEPLOY_ROOT" ) )
        {
            QString s0 = s.split ( '=' ) [1].trimmed();
            if ( s0.isEmpty() )
                continue;
            deployroot = s0;
            break;
        }
    }

    ui->lineEdit->setText ( deployroot );
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::calculate()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    progList.clear();

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

            //qDebug() << "Entry Dir" << mfi.absoluteFilePath();

            QString path = mfi.absoluteFilePath() + "/" + STR ( Q_SYS_NAME );
            QString program = path + "/";
            QString postfix;
#ifdef Q_OS_WIN
            if ( "Debug" == STR ( Q_BUILD_TYPE ) )
                postfix = "d";
            program += mfi.baseName() + postfix + ".exe";
#elif Q_OS_DARWIN
            if ( "Debug" == STR ( Q_BUILD_TYPE ) )
                postfix = "_debug";
            program += mfi.baseName() + postfix + ".app";
#else
            program += mfi.baseName();
#endif
            pline() << program;

            //"name"
            //"path"
            QQtDictionary node;
            node["name"] = mfi.baseName();
            node["path"] = program;
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
}

void MainWindow::on_pushButton_clicked()
{
    calculate();

    while ( !btnList.isEmpty() )
        btnList.removeAt ( 0 );

    for ( int i = 0; i < progList.size(); i++ )
    {
        QPushButton* btn = new QPushButton ( ui->saw );
        btn->setText ( progList[i]["name"].getValue().toString() );
        connect ( btn, SIGNAL ( clicked ( bool ) ), this, SLOT ( processProg() ) );
        btn->hide();
        btnList.push_back ( btn );
    }


    int iconW = 200;
    int iconH = 50;
    const qint8 colNum = ui->saw->width() / iconW;

    pline() << progList.getTypeName() << progList.size();
    QQtDictionaryListIterator itor ( progList.getList() );
    int index = 0;
    while ( itor.hasNext() )
    {
        const QQtDictionary& node = itor.next();
        pline() << node;

        QPushButton* w = btnList[index];

        //每行的数目是确定的。
        int i = ( index ) % colNum;

        w->setGeometry ( i * iconW, ( index ) / colNum * iconH, iconW - 2, iconH - 2 );
        w->show();

        ui->saw->setFixedHeight ( ( ( index ) / colNum + 1 ) * iconH );

        index++;
    }
}

void MainWindow::processProg()
{
    QObject* o = sender();
    QPushButton* btn = ( QPushButton* ) o;
    pline() << btn;
    pline() << btn->text();
    pline() << progMap[btn->text()]["name"].getValue().toString();
    pline() << progMap[btn->text()]["path"].getValue().toString();
    pline() << progMap[btn->text()]["program"].getValue().toString();
    pline() << progMap[btn->text()]["workpath"].getValue().toString();
    QProcess::startDetached ( progMap[btn->text()]["program"].getValue().toString(), QStringList(),
                              progMap[btn->text()]["workpath"].getValue().toString() );
}
