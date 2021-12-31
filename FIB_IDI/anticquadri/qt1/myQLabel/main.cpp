#include "myqlabel.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    myQLabel w;
    w.show();

    return a.exec();
}
