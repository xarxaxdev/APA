#include <QSlider>

class MySlider : public QSlider {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MySlider(QWidget *parent);

public slots:
  //Slots
  void posaZero();
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
