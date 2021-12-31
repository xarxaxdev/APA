#include "MyForm.h"
#include "ui_MyForm.h"

MyForm::MyForm(QWidget *parent) :
    QMyForm(parent),
    ui(new Ui::MyForm)
{
    ui->setupUi(this);
}

MyForm::~MyForm()
{
    delete ui;
}
