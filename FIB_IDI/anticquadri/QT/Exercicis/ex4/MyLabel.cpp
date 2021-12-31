#include "MyLabel.h"

int cont = 0;

MyLabel::MyLabel(QWidget *parent):QLabel(parent) {

}

void MyLabel::suma1() {
    ++cont;
    QString masuno = QString::number(cont);
    setText(masuno);
}

void MyLabel::suma2() {
    cont += 2;
    QString masdos = QString::number(cont);
    setText(masdos);
}

void MyLabel::posaZero() {
    cont = 0;
    QString zero = QString::number(cont);
    setText(zero);
}
