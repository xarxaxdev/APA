#ifndef EX3_H
#define EX3_H

#include <QMainWindow>

namespace Ui {
class ex3;
}

class ex3 : public QMainWindow
{
    Q_OBJECT

public:
    explicit ex3(QWidget *parent = 0);
    ~ex3();

private:
    Ui::ex3 *ui;
};

#endif // EX3_H
