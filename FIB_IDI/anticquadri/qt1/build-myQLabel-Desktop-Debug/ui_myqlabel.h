/********************************************************************************
** Form generated from reading UI file 'myqlabel.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MYQLABEL_H
#define UI_MYQLABEL_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_myQLabel
{
public:

    void setupUi(QWidget *myQLabel)
    {
        if (myQLabel->objectName().isEmpty())
            myQLabel->setObjectName(QString::fromUtf8("myQLabel"));
        myQLabel->resize(400, 300);

        retranslateUi(myQLabel);

        QMetaObject::connectSlotsByName(myQLabel);
    } // setupUi

    void retranslateUi(QWidget *myQLabel)
    {
        myQLabel->setWindowTitle(QApplication::translate("myQLabel", "myQLabel", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class myQLabel: public Ui_myQLabel {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MYQLABEL_H
