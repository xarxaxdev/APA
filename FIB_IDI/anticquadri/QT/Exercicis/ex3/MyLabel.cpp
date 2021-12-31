#include "MyLabel.h"

QString qnova;

MyLabel::MyLabel(QWidget *parent):QLabel(parent) {

}

void MyLabel::setTextTrunc(QString q) {
    qnova = q;
    setText(q);
}

void MyLabel::truncar(int t) {
    QString qaux = qnova;
    qaux.truncate(t);
    setText(qaux);
}
