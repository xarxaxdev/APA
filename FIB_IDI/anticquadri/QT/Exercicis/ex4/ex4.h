#ifndef EX4_H
#define EX4_H

#include <QMainWindow>

namespace Ui {
class ex4;
}

class ex4 : public QMainWindow
{
    Q_OBJECT

public:
    explicit ex4(QWidget *parent = 0);
    ~ex4();

private:
    Ui::ex4 *ui;
};

#endif // EX4_H
