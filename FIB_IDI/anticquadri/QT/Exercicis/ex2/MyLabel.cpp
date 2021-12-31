#include "MyLabel.h"

int r;
int g;
int b;

MyLabel::MyLabel(QWidget *parent):QLabel(parent) {

}

void MyLabel::saveR(int red) {
  r=red;
}

void MyLabel::saveG(int green) {
  g=green;
}

void MyLabel::saveB(int blue) {
  b=blue;
}

void MyLabel::setColor() {
      QString re = QString::number(r);
      QString gr = QString::number(g);
      QString bl = QString::number(b);
      //std::cout << s.toStdString() << std::endl;
      QString a = "background-color: rgb("+re+","+gr+","+bl+");";
      setStyleSheet(a);
}
