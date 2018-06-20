#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QStringListModel>
#include <qqtcore.h>

MainWindow::MainWindow ( QWidget* parent ) :
    QMainWindow ( parent ),
    ui ( new Ui::MainWindow )
{
    ui->setupUi ( this );

    setMinimumSize ( 1024, 600 );

    connect ( this, SIGNAL ( clickBtn() ), this, SLOT ( on_pushButton_clicked() ), Qt::QueuedConnection );

    platList << "Name"
             << "Windows"
             << "Win32"
             << "Win64"
             << "WinRT"
             << "MSVC"
             << "MSVC32"
             << "MSVC64"
             << "Linux"
             << "Linux64"
             << "Embedded"
             << "Arm32"
             << "Armhf32"
             << "Mips32"
             << "Android"
             << "macOS"
             << "iOS"
             << "iOSSimulator" ;

    ui->tableWidget->setColumnCount ( platList.size() );
    ui->tableWidget->setHorizontalHeaderLabels ( platList );
    ui->tableWidget->horizontalHeader()->setSectionResizeMode ( QHeaderView::ResizeToContents );
    ui->tableWidget->setSelectionMode ( QAbstractItemView::MultiSelection );
    ui->tableWidget->setSelectionBehavior ( QAbstractItemView::SelectRows );

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

    emit clickBtn();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    if ( ui->lineEdit->text().isEmpty() )
        return;

    ui->statusBar->showMessage ( "processing...." );

    //这个函数清空了header 。。。。。神啊。。。
    //ui->tableWidget->clear();

    while ( ui->tableWidget->rowCount() > 0 )
        ui->tableWidget->removeRow ( 0 );

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

            ui->tableWidget->setRowCount ( ui->tableWidget->rowCount() + 1 );

            //如果直接使用，却不new item，会崩溃退出。
            //虽然设置了count，但是里面没有item。
            //ui->tableWidget->item ( row, 0 )->setText ( mfi.fileName() );

            QTableWidgetItem* item = new QTableWidgetItem ( mfi.fileName() );
            ui->tableWidget->setItem ( row, 0, item );

            int col = 1;
            QStringListIterator itor ( platList );
            while ( itor.hasNext() )
            {
                itor.next();
                QTableWidgetItem* item = new QTableWidgetItem();
                item->setFlags ( item->flags() | Qt::ItemIsUserCheckable );
                item->setCheckState ( Qt::Unchecked );
                ui->tableWidget->setItem ( row, col, item );
                col++;
            }

            QDir d ( ui->lineEdit->text() + "/" + mfi.fileName() );
            foreach ( QFileInfo mfi, d.entryInfoList() )
            {

                if ( mfi.isFile() ) {}
                else
                {
                    if ( mfi.fileName() == "." || mfi.fileName() == ".." )
                        continue;

                    int index = 0;
                    QStringListIterator itor ( platList );
                    while ( itor.hasNext() )
                    {
                        QString str = itor.next();
                        if ( str == mfi.fileName() )
                        {
                            ui->tableWidget->item ( row, index )->setCheckState ( Qt::Checked );
                            break;
                        }
                        index++;
                    }

                }
            }

            row++;
        }
    }


    ui->statusBar->showMessage ( "Successed." );

}
