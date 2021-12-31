#include "examen.h"
#include "ui_examen.h"

examen::examen(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::examen)
{
    ui->setupUi(this);
}

examen::~examen()
{
    delete ui;
}
