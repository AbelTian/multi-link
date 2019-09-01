#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <linkstaticlibtest.h>
#include <linkdynamiclibtest.h>

MainWindow::MainWindow ( QWidget* parent ) :
    QMainWindow ( parent ),
    ui ( new Ui::MainWindow )
{
    ui->setupUi ( this );

    LinkStaticLibTest test;
    LinkDynamicLibTest test2;
}

MainWindow::~MainWindow()
{
    delete ui;
}
