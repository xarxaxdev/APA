#include "myqtextedit.h"

QString num;
QString text;

MyQTextEdit::MyQTextEdit(QWidget *parent):QTextEdit(parent) {

}

void MyQTextEdit::getNum(QString n) {
    num = n;
}

void MyQTextEdit::getText(QString t) {
    text = t;
}

void MyQTextEdit::appendCompra() {
    QString result = num + " " + text;
    append(result);
}
