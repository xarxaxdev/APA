#ifndef EX6_H
#define EX6_H

#include <QMainWindow>

namespace Ui {
class ex6;
}

class ex6 : public QMainWindow
{
    Q_OBJECT

public:
    explicit ex6(QWidget *parent = 0);
    ~ex6();

private:
    Ui::ex6 *ui;
};

#endif // EX6_H
