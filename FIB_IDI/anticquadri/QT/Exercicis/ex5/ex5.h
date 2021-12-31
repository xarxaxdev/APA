#ifndef EX5_H
#define EX5_H

#include <QMainWindow>

namespace Ui {
class ex5;
}

class ex5 : public QMainWindow
{
    Q_OBJECT

public:
    explicit ex5(QWidget *parent = 0);
    ~ex5();

private:
    Ui::ex5 *ui;
};

#endif // EX5_H
