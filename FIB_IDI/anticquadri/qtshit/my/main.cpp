#include "my.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    my w;
    w.show();
    return a.exec();
}
