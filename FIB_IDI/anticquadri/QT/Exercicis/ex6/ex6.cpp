#include "ex6.h"
#include "ui_ex6.h"

ex6::ex6(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex6)
{
    ui->setupUi(this);
}

ex6::~ex6()
{
    delete ui;
}
