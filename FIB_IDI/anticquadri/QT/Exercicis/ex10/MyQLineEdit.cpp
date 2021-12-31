#include "MyQLineEdit.h"

bool s = false;
QString result;

MyQLineEdit::MyQLineEdit(QWidget *parent):QLineEdit(parent) {

}

void MyQLineEdit::shift() {
    if (s) s = false;
    else s = true;
}

void MyQLineEdit::lletraA() {
    if (s) result += "A";
    else result += "a";
    setText(result);
}

void MyQLineEdit::lletraE() {
    if (s) result += "E";
    else result += "e";
    setText(result);
}

void MyQLineEdit::lletraI() {
    if (s) result += "I";
    else result += "i";
    setText(result);
}

void MyQLineEdit::lletraO() {
    if (s) result += "O";
    else result += "o";
    setText(result);
}

void MyQLineEdit::lletraU() {
    if (s) result += "U";
    else result += "u";
    setText(result);
}
