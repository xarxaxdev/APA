
#include "myqlabel.h"

myQLabel::myQLabel(QWidget* parent): QLabel(parent)
{
    ui.setupUi(this);
};


void myQLabel::setText(QString & s){
    for(int i=0;i<s.length();i++){
        if(i%2==0)s[i]==s[i]+'0';
    }
};
