#include <QLCDNumber>

class MyQLCDNumber : public QLCDNumber {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyQLCDNumber(QWidget *parent);

public slots:
  //Slots
  void toggle1();
  void toggle2();
  void check1(bool);
  void check2(bool);
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
