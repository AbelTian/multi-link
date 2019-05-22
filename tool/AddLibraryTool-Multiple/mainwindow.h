#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <qqtdictionary.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow ( QWidget* parent = 0 );
    ~MainWindow();

    void calculate ( QQtDictionary& dict, QString path );
    //void calculateLib ( QQtDictionary& dict, QString path );
    void outputWrokflow ( QString sdkName );

    void setOutputPath ( QString path );

signals:
    void clickBtn();

protected slots:
    void textChanged ( QString );

private:
    QByteArray fileBytes;

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

private:
    Ui::MainWindow* ui;

    // QObject interface
public:
    virtual bool eventFilter ( QObject* watched, QEvent* event ) override;
};

#endif // MAINWINDOW_H
