/********************************************************************************
** Form generated from reading UI file 'ex7.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX7_H
#define UI_EX7_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QPushButton>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>
#include "mylabel.h"

QT_BEGIN_NAMESPACE

class Ui_ex7
{
public:
    QVBoxLayout *verticalLayout;
    MyLabel *label;
    QPushButton *pushButton;
    QPushButton *pushButton_2;

    void setupUi(QWidget *ex7)
    {
        if (ex7->objectName().isEmpty())
            ex7->setObjectName(QString::fromUtf8("ex7"));
        ex7->resize(400, 300);
        verticalLayout = new QVBoxLayout(ex7);
        verticalLayout->setSpacing(6);
        verticalLayout->setContentsMargins(11, 11, 11, 11);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        label = new MyLabel(ex7);
        label->setObjectName(QString::fromUtf8("label"));
        label->setStyleSheet(QString::fromUtf8("background-color: rgba(255,0,0,255)"));

        verticalLayout->addWidget(label);

        pushButton = new QPushButton(ex7);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        verticalLayout->addWidget(pushButton);

        pushButton_2 = new QPushButton(ex7);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        verticalLayout->addWidget(pushButton_2);


        retranslateUi(ex7);
        QObject::connect(pushButton_2, SIGNAL(clicked()), ex7, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), label, SLOT(canvi()));

        QMetaObject::connectSlotsByName(ex7);
    } // setupUi

    void retranslateUi(QWidget *ex7)
    {
        ex7->setWindowTitle(QApplication::translate("ex7", "ex7", 0, QApplication::UnicodeUTF8));
        label->setText(QString());
        pushButton->setText(QApplication::translate("ex7", "Canvi", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex7", "&Sortir", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex7: public Ui_ex7 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX7_H
