#ifndef EX10_H
#define EX10_H

#include <QWidget>

namespace Ui {
class ex10;
}

class ex10 : public QWidget
{
    Q_OBJECT

public:
    explicit ex10(QWidget *parent = 0);
    ~ex10();

private:
    Ui::ex10 *ui;
};

#endif // EX10_H
