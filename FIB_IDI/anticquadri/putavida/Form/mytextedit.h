#include <QTextEdit>

class mytextedit : public QTextEdit {
  Q_OBJECT //Macro de QT

public:
  //Mètodes públics
  mytextedit(QWidget *parent);

public slots:
  //Slots
    void encript(int);
signals:
  //Signals


private:
  //Part privada de la classe

};
