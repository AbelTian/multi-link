#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <qqtdictionary.h>
#include <QProcess>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow ( QWidget* parent = 0 );
    ~MainWindow();

    void calculate();

signals:
    void clickBtn();

private slots:
    void on_pushButton_clicked();
    void processProg();

private:
    QQtDictionary progList;
    QQtDictionary progMap;
    QList<QPushButton*> btnList;

private:
    Ui::MainWindow* ui;
};

#endif // MAINWINDOW_H
