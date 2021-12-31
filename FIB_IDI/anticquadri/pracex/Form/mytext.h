#include <QTextEdit>

class mytext : public QTextEdit {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  mytext(QWidget *parent);

public slots:
  //Slots
    void encript(QString);
signals:
  //Signals
    void canvi(QString);

private:
  //Part privada de la classe
  QString textbase="";
  int salts=0;

};
