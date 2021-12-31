#include "ex4.h"
#include "ui_ex4.h"

ex4::ex4(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex4)
{
    ui->setupUi(this);
}

ex4::~ex4()
{
    delete ui;
}
