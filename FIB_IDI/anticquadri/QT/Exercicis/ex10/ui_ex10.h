/********************************************************************************
** Form generated from reading UI file 'ex10.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX10_H
#define UI_EX10_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>
#include <myqlineedit.h>

QT_BEGIN_NAMESPACE

class Ui_ex10
{
public:
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QPushButton *pushButton_3;
    QPushButton *pushButton_4;
    QPushButton *pushButton_5;
    QPushButton *pushButton_6;
    MyQLineEdit *lineEdit;
    QSpacerItem *verticalSpacer;
    QPushButton *pushButton_7;

    void setupUi(QWidget *ex10)
    {
        if (ex10->objectName().isEmpty())
            ex10->setObjectName(QString::fromUtf8("ex10"));
        ex10->resize(586, 276);
        verticalLayout = new QVBoxLayout(ex10);
        verticalLayout->setSpacing(6);
        verticalLayout->setContentsMargins(11, 11, 11, 11);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        pushButton = new QPushButton(ex10);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        horizontalLayout->addWidget(pushButton);

        pushButton_2 = new QPushButton(ex10);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        horizontalLayout->addWidget(pushButton_2);

        pushButton_3 = new QPushButton(ex10);
        pushButton_3->setObjectName(QString::fromUtf8("pushButton_3"));

        horizontalLayout->addWidget(pushButton_3);

        pushButton_4 = new QPushButton(ex10);
        pushButton_4->setObjectName(QString::fromUtf8("pushButton_4"));

        horizontalLayout->addWidget(pushButton_4);

        pushButton_5 = new QPushButton(ex10);
        pushButton_5->setObjectName(QString::fromUtf8("pushButton_5"));

        horizontalLayout->addWidget(pushButton_5);


        verticalLayout->addLayout(horizontalLayout);

        pushButton_6 = new QPushButton(ex10);
        pushButton_6->setObjectName(QString::fromUtf8("pushButton_6"));

        verticalLayout->addWidget(pushButton_6);

        lineEdit = new MyQLineEdit(ex10);
        lineEdit->setObjectName(QString::fromUtf8("lineEdit"));

        verticalLayout->addWidget(lineEdit);

        verticalSpacer = new QSpacerItem(20, 98, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout->addItem(verticalSpacer);

        pushButton_7 = new QPushButton(ex10);
        pushButton_7->setObjectName(QString::fromUtf8("pushButton_7"));

        verticalLayout->addWidget(pushButton_7);


        retranslateUi(ex10);
        QObject::connect(pushButton_7, SIGNAL(clicked()), ex10, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), lineEdit, SLOT(lletraA()));
        QObject::connect(pushButton_2, SIGNAL(clicked()), lineEdit, SLOT(lletraE()));
        QObject::connect(pushButton_3, SIGNAL(clicked()), lineEdit, SLOT(lletraI()));
        QObject::connect(pushButton_4, SIGNAL(clicked()), lineEdit, SLOT(lletraO()));
        QObject::connect(pushButton_5, SIGNAL(clicked()), lineEdit, SLOT(lletraU()));
        QObject::connect(pushButton_6, SIGNAL(clicked()), lineEdit, SLOT(shift()));

        QMetaObject::connectSlotsByName(ex10);
    } // setupUi

    void retranslateUi(QWidget *ex10)
    {
        ex10->setWindowTitle(QApplication::translate("ex10", "ex10", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex10", "A", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex10", "E", 0, QApplication::UnicodeUTF8));
        pushButton_3->setText(QApplication::translate("ex10", "I", 0, QApplication::UnicodeUTF8));
        pushButton_4->setText(QApplication::translate("ex10", "O", 0, QApplication::UnicodeUTF8));
        pushButton_5->setText(QApplication::translate("ex10", "U", 0, QApplication::UnicodeUTF8));
        pushButton_6->setText(QApplication::translate("ex10", "Shift", 0, QApplication::UnicodeUTF8));
        pushButton_7->setText(QApplication::translate("ex10", "Quit", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex10: public Ui_ex10 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX10_H
