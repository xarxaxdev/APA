#include "MyLabel.h"

int cont = 0;

MyLabel::MyLabel(QWidget *parent):QLabel(parent) {

}

void MyLabel::canvi() {
    ++cont;
    if (cont%3 == 0) setStyleSheet("background-color: rgba(255,0,0,255)");
    if (cont%3 == 1) setStyleSheet("background-color: rgba(255,255,0,255)");
    if (cont%3 == 2) setStyleSheet("background-color: rgba(0,255,0,255)");
}
