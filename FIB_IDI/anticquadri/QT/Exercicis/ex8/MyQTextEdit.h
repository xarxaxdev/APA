#include <QTextEdit>

class MyQTextEdit : public QTextEdit {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  MyQTextEdit(QWidget *parent);

public slots:
  //Slots
  void getNum(QString);
  void getText(QString);
  void appendCompra();
signals:
  //Signals
  void exempleSignal();

private:
  //Part privada de la classe

};
