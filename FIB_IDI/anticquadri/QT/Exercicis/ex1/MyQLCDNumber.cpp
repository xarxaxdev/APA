#include "MyQLCDNumber.h"

MyQLCDNumber::MyQLCDNumber(QWidget *parent):QLCDNumber(parent) {

}

void MyQLCDNumber::displayZero() {
    setStyleSheet("color: green;");
    display(0);
}

void MyQLCDNumber::changeValueColor(int num) {
    if(num%2==0) {
        setStyleSheet("color: blue;");
        display(num);
    }
    if(num==0) {
        setStyleSheet("color: green;");
        display(num);
    }
    if(num%2!=0) {
        setStyleSheet("color: red;");
        display(num);
    }
}
