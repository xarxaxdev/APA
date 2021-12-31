#include <QApplication>
#include <QFrame>
#include <QLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLCDNumber>
#include <QDial>

int main( int argc, char ** argv)
{
  // Creem tots els components
  QApplication app(argc, argv);
  QFrame *w=new QFrame();
  QVBoxLayout *mainLayout=new QVBoxLayout(w);
  QHBoxLayout *layHoriz1  = new QHBoxLayout(),*layHoriz2  = new QHBoxLayout()
          ,*layHoriz3  = new QHBoxLayout();
  QLabel *hours   = new QLabel ( "Hours", w), *mins= new QLabel("Minutes",w); //lbl1
  QLCDNumber *n1=new QLCDNumber(), *n2=new QLCDNumber();
  QDial *d1=new QDial(), *d2= new QDial();
  //exit
  QHBoxLayout *qButtonLayout = new QHBoxLayout();
  QPushButton *quitButton = new QPushButton("&Exit", w);

  // Insertem el label i el editor de text al primer layout horizontal

  layHoriz1->addWidget(hours);
  layHoriz1->addWidget(mins);


  //2n layout
  layHoriz2->addWidget(n1);
  layHoriz2->addWidget(n2);

  //3r layout
  layHoriz3->addWidget(d1);
  layHoriz3->addWidget(d2);

  //ext
  qButtonLayout->addItem(new QSpacerItem(30,10,QSizePolicy::Expanding,QSizePolicy::Minimum));
  qButtonLayout->addWidget(quitButton);
  
  // Afegim tots els elements dins del layout principal
  mainLayout->addLayout(layHoriz1);
  mainLayout->addLayout(layHoriz2);
  mainLayout->addLayout(layHoriz3);
  mainLayout->addLayout(qButtonLayout);

  app.connect(quitButton, SIGNAL(clicked()), w, SLOT(close()));

  w->show();
  return app.exec();
}
