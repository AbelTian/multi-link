#include "mainwindow.h"
#include <QQtApplication>

#include <docopt.h>
#include <iostream>

static const char USAGE[] =
    R"(AddLibraryTool-Multiple v1.0.

    Usage:
      AddLibraryTool-Multiple
      AddLibraryTool-Multiple output <root>
      AddLibraryTool-Multiple (-h | --help)
      AddLibraryTool-Multiple --version

    Options:
      -h --help     Show this screen.
      --version     Show version.
)";


int main ( int argc, char* argv[] )
{
    QQtApplication a ( argc, argv );
    MainWindow w;
    w.show();

    std::map<std::string, docopt::value> args = docopt::docopt(USAGE,
                                                  { argv + 1, argv + argc },
                                                  true,               // show help if requested
                                                  "AddLibraryTool-Multiple v1.0");  // version string

    if(bool(args["<root>"]) && args["<root>"] != docopt::value(""))
        w.setOutputPath(QString::fromStdString(args["<root>"].asString()));

    return a.exec();
}
