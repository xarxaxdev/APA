#include "my.h"
#include "ui_my.h"

my::my(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::my)
{
    ui->setupUi(this);
}

my::~my()
{
    delete ui;
}
