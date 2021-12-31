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
  void setTextTrunc(QString);
  void truncar(int);
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
