#ifndef EX9_H
#define EX9_H

#include <QWidget>

namespace Ui {
class ex9;
}

class ex9 : public QWidget
{
    Q_OBJECT

public:
    explicit ex9(QWidget *parent = 0);
    ~ex9();

private:
    Ui::ex9 *ui;
};

#endif // EX9_H
