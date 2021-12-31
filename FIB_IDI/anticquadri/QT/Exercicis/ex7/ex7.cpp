#include "ex7.h"
#include "ui_ex7.h"

ex7::ex7(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ex7)
{
    ui->setupUi(this);
}

ex7::~ex7()
{
    delete ui;
}
