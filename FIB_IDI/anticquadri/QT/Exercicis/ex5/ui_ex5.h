/********************************************************************************
** Form generated from reading UI file 'ex5.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX5_H
#define UI_EX5_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>
#include <mylabel.h>

QT_BEGIN_NAMESPACE

class Ui_ex5
{
public:
    QWidget *centralWidget;
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout;
    MyLabel *label;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QHBoxLayout *horizontalLayout_2;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_3;

    void setupUi(QMainWindow *ex5)
    {
        if (ex5->objectName().isEmpty())
            ex5->setObjectName(QString::fromUtf8("ex5"));
        ex5->resize(261, 166);
        centralWidget = new QWidget(ex5);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        verticalLayout = new QVBoxLayout(centralWidget);
        verticalLayout->setSpacing(6);
        verticalLayout->setContentsMargins(11, 11, 11, 11);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
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


        verticalLayout->addLayout(horizontalLayout);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout_2->addItem(horizontalSpacer);

        pushButton_3 = new QPushButton(centralWidget);
        pushButton_3->setObjectName(QString::fromUtf8("pushButton_3"));

        horizontalLayout_2->addWidget(pushButton_3);


        verticalLayout->addLayout(horizontalLayout_2);

        ex5->setCentralWidget(centralWidget);

        retranslateUi(ex5);
        QObject::connect(pushButton_3, SIGNAL(clicked()), ex5, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), label, SLOT(creu()));
        QObject::connect(pushButton_2, SIGNAL(clicked()), label, SLOT(cercle()));

        QMetaObject::connectSlotsByName(ex5);
    } // setupUi

    void retranslateUi(QMainWindow *ex5)
    {
        ex5->setWindowTitle(QApplication::translate("ex5", "ex5", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("ex5", "X", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex5", "Creu", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex5", "Cercle", 0, QApplication::UnicodeUTF8));
        pushButton_3->setText(QApplication::translate("ex5", "&Sortir", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex5: public Ui_ex5 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX5_H
