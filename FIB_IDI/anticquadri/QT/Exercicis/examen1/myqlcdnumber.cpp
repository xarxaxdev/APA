#include "myqlcdnumber.h"

bool marcat1 = true;
bool marcat2 = true;
int cont1 = 1;
int cont2 = 1;

MyQLCDNumber::MyQLCDNumber(QWidget *parent):QLCDNumber(parent) {

}

void MyQLCDNumber::check1(bool marca1) {
    if (marca1) {
        ++cont1;
        marcat1 = true;
    }else marcat1 = false;
    setVisible(marca1);
    display(cont1);
}

void MyQLCDNumber::toggle1() {
    if (marcat1) {
        marcat1 = false;
        setVisible(marcat1);
    }else {
        marcat1 = true;
        ++cont1;
        setVisible(marcat1);
        display(cont1);
    }
}

void MyQLCDNumber::check2(bool marca2) {
    if (marca2) {
        ++cont2;
        marcat2 = true;
    }else marcat2 = false;
    setVisible(marca2);
    display(cont2);
}

void MyQLCDNumber::toggle2() {
    if (marcat2) {
        marcat2 = false;
        setVisible(marcat2);
    }else {
        marcat2 = true;
        ++cont2;
        setVisible(marcat2);
        display(cont2);
    }
}

