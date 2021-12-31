#include "felis.h"
#include <time.h>



felis::felis(QWidget *parent):QPushButton(parent) {

}


void felis::spin (int a){
   b1+=a;
   b2+=a;
   b3+=a;
   b4+=a;
   b5+=a;
   b6+=a;
   if(this->objectName()=="b1") setStyleSheet(choosecolor(b1));
   if(this->objectName()=="b2") setStyleSheet(choosecolor(b2));
   if(this->objectName()=="b3") setStyleSheet(choosecolor(b3));
   if(this->objectName()=="b4") setStyleSheet(choosecolor(b4));
   if(this->objectName()=="b5") setStyleSheet(choosecolor(b5));
   if(this->objectName()=="b6") setStyleSheet(choosecolor(b6));
}


void felis::reset (){
    srand(time(NULL));
    b1=qrand();
    b2=qrand();
    b3=qrand();
    b4=qrand();
    b5=qrand();
    b6=qrand();
    if(this->objectName()=="b1") setStyleSheet(choosecolor(b1));
    if(this->objectName()=="b2") setStyleSheet(choosecolor(b2));
    if(this->objectName()=="b3") setStyleSheet(choosecolor(b3));
    if(this->objectName()=="b4") setStyleSheet(choosecolor(b4));
    if(this->objectName()=="b5") setStyleSheet(choosecolor(b5));
    if(this->objectName()=="b6") setStyleSheet(choosecolor(b6));
}

QString felis::choosecolor(int n){
    if(n%4==0) return "background-color: rgba(0,0,255,255)";
    if(n%4==1) return "background-color: rgba(0,255,0,255)";
    if(n%4==2) return "background-color: rgba(255,0,0,255)";
    else return "background-color: rgba(255,128,128,255)";
}
