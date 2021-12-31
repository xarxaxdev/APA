/********************************************************************************
** Form generated from reading UI file 'my.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MY_H
#define UI_MY_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_my
{
public:

    void setupUi(QWidget *my)
    {
        if (my->objectName().isEmpty())
            my->setObjectName(QString::fromUtf8("my"));
        my->resize(400, 300);

        retranslateUi(my);

        QMetaObject::connectSlotsByName(my);
    } // setupUi

    void retranslateUi(QWidget *my)
    {
        my->setWindowTitle(QApplication::translate("my", "my", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class my: public Ui_my {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MY_H
