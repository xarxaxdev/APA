#include <QLabel>
#include <iostream>
using namespace std;

class MyLabel : public QLabel {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyLabel(QWidget *parent);

public slots:
  //Slots
  void canvi();
signals:
  //Signals

private:
  //Part privada de la classe

};
