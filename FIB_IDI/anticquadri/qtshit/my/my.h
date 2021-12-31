#ifndef MY_H
#define MY_H

#include <QWidget>

namespace Ui {
class my;
}

class my : public QWidget
{
    Q_OBJECT

public:
    explicit my(QWidget *parent = 0);
    ~my();

private:
    Ui::my *ui;
};

#endif // MY_H
