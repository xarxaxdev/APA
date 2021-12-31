#include <QPushButton>

class felis : public QPushButton {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  felis(QWidget *parent);

public slots:
  //Slots
  void spin(int);
  void reset();
signals:
  //Signals


private:
  //Part privada de la classe
    uint b1,b2,b3,b4,b5,b6;
    QString choosecolor(int);
};
