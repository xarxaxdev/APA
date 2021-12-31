#include "ex1.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    ex1 w;
    w.show();

    return a.exec();
}
