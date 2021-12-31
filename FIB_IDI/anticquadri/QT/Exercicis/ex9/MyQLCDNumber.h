#include <QLCDNumber>

class MyQLCDNumber : public QLCDNumber {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyQLCDNumber(QWidget *parent);

public slots:
  //Slots
  void diferencial(int);
  void suma();
  void resta();
  void undo();
  void reset();
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
