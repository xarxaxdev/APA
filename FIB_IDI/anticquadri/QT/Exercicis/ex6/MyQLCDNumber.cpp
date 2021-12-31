#include "MyQLCDNumber.h"

MyQLCDNumber::MyQLCDNumber(QWidget *parent):QLCDNumber(parent) {

}

void MyQLCDNumber::posaZero() {
    display(0);
}

void MyQLCDNumber::base3(int num) {
    int cont = 1;
    int result = 0;
    if(num == 0){
        display(0);
    }else{
        while(num>=1){
            result = result + (cont*(num%3));
            num = num/3;
            cont = cont*10;
        }
        display(result);
    }
}
