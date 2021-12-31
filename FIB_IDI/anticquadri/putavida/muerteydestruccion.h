#include <QTextEdit>

class muerteydestruccion : public QTextEdit {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  muerteydestruccion(QWidget *parent);

public slots:
  //Slots
    void mantis();
signals:
  //Signals


private:
  //Part privada de la classe

};
