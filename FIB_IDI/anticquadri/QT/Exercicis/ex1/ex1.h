#ifndef EX1_H
#define EX1_H

#include <QMainWindow>

namespace Ui {
class ex1;
}

class ex1 : public QMainWindow
{
    Q_OBJECT

public:
    explicit ex1(QWidget *parent = 0);
    ~ex1();

private:
    Ui::ex1 *ui;
};

#endif // EX1_H
