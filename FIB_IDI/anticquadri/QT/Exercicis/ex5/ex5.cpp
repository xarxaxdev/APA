#include "ex5.h"
#include "ui_ex5.h"

ex5::ex5(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex5)
{
    ui->setupUi(this);
}

ex5::~ex5()
{
    delete ui;
}
