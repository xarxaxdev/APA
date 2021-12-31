#include "ex9.h"
#include "ui_ex9.h"

ex9::ex9(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ex9)
{
    ui->setupUi(this);
}

ex9::~ex9()
{
    delete ui;
}
