#include "MyQLCDNumber.h"

int dif = 1;
int cont = 0;
int aux;

MyQLCDNumber::MyQLCDNumber(QWidget *parent):QLCDNumber(parent) {

}

void MyQLCDNumber::reset() {
    aux = cont;
    cont = 0;
    display(cont);
}

void MyQLCDNumber::diferencial(int num) {
    dif = num;
}

void MyQLCDNumber::suma() {
    aux = cont;
    cont += dif;
    display(cont);
}

void MyQLCDNumber::resta() {
    aux = cont;
    cont -= dif;
    display(cont);
}

void MyQLCDNumber::undo() {
    display(aux);
    cont = aux;
}
