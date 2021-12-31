#include "muerteydestruccion.h"

QString hue;

muerteydestruccion::muerteydestruccion(QWidget *parent):QTextEdit(parent) {

}


void muerteydestruccion::mantis (){
   hue = this->toPlainText();
   hue = QString :: number((hue).toInt() +1);
   this->setText(hue);
}
