#include "ex3.h"
#include "ui_ex3.h"

ex3::ex3(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ex3)
{
    ui->setupUi(this);
}

ex3::~ex3()
{
    delete ui;
}
