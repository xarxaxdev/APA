#include <QLineEdit>

class MyQLineEdit : public QLineEdit{
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyQLineEdit(QWidget *parent);

public slots:
  //Slots
  void shift();
  void lletraA();
  void lletraE();
  void lletraI();
  void lletraO();
  void lletraU();
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
