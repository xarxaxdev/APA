#include "examen.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    examen w;
    w.show();

    return a.exec();
}
