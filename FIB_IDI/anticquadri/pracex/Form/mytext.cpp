#include "mytext.h"
#include <string>
mytext::mytext(QWidget *parent):QTextEdit(parent) {

}

void mytext::encript (QString text){
   QChar a;
   QString b="";
   for(int i=0;i<text.size();i++){
       a=QChar((text.at(i)).digitValue()+1);
       b.append(a);
   }
   this->setText(b);
}
