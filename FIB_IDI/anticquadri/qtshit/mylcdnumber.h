#ifndef MYLCDNUMBER_H
#define MYLCDNUMBER_H

#include <QLCDNumber>


class mylcdnumber : public QLCDNumber
{
    Q_OBJECT
public:
    explicit mylcdnumber(QWidget *parent = 0);

signals:

public slots:
    void numchanged(int);
    void zero();

};

#endif // MYLCDNUMBER_H
