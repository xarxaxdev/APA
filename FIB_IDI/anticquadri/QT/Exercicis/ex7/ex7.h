#ifndef EX7_H
#define EX7_H

#include <QWidget>

namespace Ui {
class ex7;
}

class ex7 : public QWidget
{
    Q_OBJECT

public:
    explicit ex7(QWidget *parent = 0);
    ~ex7();

private:
    Ui::ex7 *ui;
};

#endif // EX7_H
