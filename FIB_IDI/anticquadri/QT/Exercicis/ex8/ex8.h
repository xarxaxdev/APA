#ifndef EX8_H
#define EX8_H

#include <QWidget>

namespace Ui {
class ex8;
}

class ex8 : public QWidget
{
    Q_OBJECT

public:
    explicit ex8(QWidget *parent = 0);
    ~ex8();

private:
    Ui::ex8 *ui;
};

#endif // EX8_H
