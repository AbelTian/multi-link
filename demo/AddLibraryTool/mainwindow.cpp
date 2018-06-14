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
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    ui->textBrowser->clear();

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
}
