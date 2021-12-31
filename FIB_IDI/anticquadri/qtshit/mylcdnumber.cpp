#include "mylcdnumber.h"

mylcdnumber::mylcdnumber(QWidget *parent) : QLCDNumber(parent)
{
}

void mylcdnumber::numchanged(int number)
{
    if ( number )
    {
        if ( number % 2 ) this->setStyleSheet("color: red");
        else this->setStyleSheet("color: blue");
    } else this->setStyleSheet("color: green");
}

void mylcdnumber::zero()
{
    numchanged(0);
    this->display(0);
}
