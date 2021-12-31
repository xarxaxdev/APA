#ifndef EXAMEN_H
#define EXAMEN_H

#include <QWidget>

namespace Ui {
class examen;
}

class examen : public QWidget
{
    Q_OBJECT

public:
    explicit examen(QWidget *parent = 0);
    ~examen();

private:
    Ui::examen *ui;
};

#endif // EXAMEN_H
