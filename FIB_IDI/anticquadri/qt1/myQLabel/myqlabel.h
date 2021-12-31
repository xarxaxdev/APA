#include "myQLabel/myqlabel.ui

class myQLabel:  public QLabel{
    Q_OBJECT
private:
    ui::myForm ui;
public:
    myQLabel(QWidget* parent=0);
public slots:
    void setText(QString);

signals:
    void valueChanged(int);

};
