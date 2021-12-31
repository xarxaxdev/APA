#include "ex10.h"
#include "ui_ex10.h"

ex10::ex10(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ex10)
{
    ui->setupUi(this);
}

ex10::~ex10()
{
    delete ui;
}
