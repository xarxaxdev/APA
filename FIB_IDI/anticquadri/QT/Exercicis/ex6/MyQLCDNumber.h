#include <QLCDNumber>

class MyQLCDNumber : public QLCDNumber {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyQLCDNumber(QWidget *parent);

public slots:
  //Slots
  void posaZero();
  void base3(int);
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
