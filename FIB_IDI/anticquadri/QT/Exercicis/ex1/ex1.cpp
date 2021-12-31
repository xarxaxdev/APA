#include "ex1.h"
#include "ui_ex1.h"

ex1::ex1(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex1)
{
    ui->setupUi(this);
}

ex1::~ex1()
{
    delete ui;
}
