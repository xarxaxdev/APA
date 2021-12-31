#include "ex8.h"
#include "ui_ex8.h"

ex8::ex8(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ex8)
{
    ui->setupUi(this);
}

ex8::~ex8()
{
    delete ui;
}
