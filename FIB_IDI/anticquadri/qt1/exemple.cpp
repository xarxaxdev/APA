#include <QApplication>
#include <QPushButton>
#include <QLayout>
#include <QFrame>
#include <QLineEdit>
#include "myQLabel/myqlabel.h"

int main (int argc, char **argv){
    QApplication app (argc,argv);


    //DECLARACIO LAYOUTS
    QString fontFamily= "Sans";
    app.setFont(fontFamily);
    //quadre
    QFrame F(0,NULL);
    //contenidor horitzontal
    QVBoxLayout* cH= new QVBoxLayout(&F);
    //nou text
    myQLabel *label_nouText  = new myQLabel(&F);  //lbl2
    //caixa text
    QLineEdit* le = new QLineEdit(&F);
    //afegir spacer
    QSpacerItem * sp = new QSpacerItem(200,25);
    //boto
    QPushButton* ok = new QPushButton("Definitelynotok",&F);
    //mes botons
    QPushButton* surt= new QPushButton("Run away",&F);


    //afegir widgets
    cH->addWidget(label_nouText);
    cH->addWidget(le);
    cH->addItem(sp);
    cH->addWidget(ok);
    cH->addWidget(surt);



    //afegim funcionalitats
    app.connect(surt,SIGNAL(clicked()),&F,SLOT(close()));
    app.connect(le,  SIGNAL(textChanged(const QString &)),label_nouText , SLOT(setText(const QString&)));

    //finalitzacio(carregar imatges a la app i dir-li que s'executi
    F.show();
    return app.exec();
}
