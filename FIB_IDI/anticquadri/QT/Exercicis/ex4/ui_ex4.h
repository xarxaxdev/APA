/********************************************************************************
** Form generated from reading UI file 'ex4.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX4_H
#define UI_EX4_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QWidget>
#include <mylabel.h>

QT_BEGIN_NAMESPACE

class Ui_ex4
{
public:
    QWidget *centralWidget;
    QHBoxLayout *horizontalLayout;
    MyLabel *label;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QPushButton *pushButton_3;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_4;

    void setupUi(QMainWindow *ex4)
    {
        if (ex4->objectName().isEmpty())
            ex4->setObjectName(QString::fromUtf8("ex4"));
        ex4->resize(420, 55);
        centralWidget = new QWidget(ex4);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        horizontalLayout = new QHBoxLayout(centralWidget);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        label = new MyLabel(centralWidget);
        label->setObjectName(QString::fromUtf8("label"));

        horizontalLayout->addWidget(label);

        pushButton = new QPushButton(centralWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        horizontalLayout->addWidget(pushButton);

        pushButton_2 = new QPushButton(centralWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        horizontalLayout->addWidget(pushButton_2);

        pushButton_3 = new QPushButton(centralWidget);
        pushButton_3->setObjectName(QString::fromUtf8("pushButton_3"));

        horizontalLayout->addWidget(pushButton_3);

        horizontalSpacer = new QSpacerItem(141, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);

        pushButton_4 = new QPushButton(centralWidget);
        pushButton_4->setObjectName(QString::fromUtf8("pushButton_4"));

        horizontalLayout->addWidget(pushButton_4);

        ex4->setCentralWidget(centralWidget);

        retranslateUi(ex4);
        QObject::connect(pushButton_4, SIGNAL(clicked()), ex4, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), label, SLOT(suma1()));
        QObject::connect(pushButton_2, SIGNAL(clicked()), label, SLOT(suma2()));
        QObject::connect(pushButton_3, SIGNAL(clicked()), label, SLOT(posaZero()));

        QMetaObject::connectSlotsByName(ex4);
    } // setupUi

    void retranslateUi(QMainWindow *ex4)
    {
        ex4->setWindowTitle(QApplication::translate("ex4", "ex4", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("ex4", "0", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex4", "1", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex4", "2", 0, QApplication::UnicodeUTF8));
        pushButton_3->setText(QApplication::translate("ex4", "C", 0, QApplication::UnicodeUTF8));
        pushButton_4->setText(QApplication::translate("ex4", "&Surt", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex4: public Ui_ex4 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX4_H
