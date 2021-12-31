#include "ex2.h"
#include "ui_ex2.h"

ex2::ex2(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex2)
{
    ui->setupUi(this);
}

ex2::~ex2()
{
    delete ui;
}
