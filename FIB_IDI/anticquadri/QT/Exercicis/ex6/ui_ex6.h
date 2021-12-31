/********************************************************************************
** Form generated from reading UI file 'ex6.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX6_H
#define UI_EX6_H

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
#include <myqlcdnumber.h>
#include <myslider.h>

QT_BEGIN_NAMESPACE

class Ui_ex6
{
public:
    QWidget *centralWidget;
    QHBoxLayout *horizontalLayout;
    MyQLCDNumber *lcdNumber;
    MySlider *horizontalSlider;
    QPushButton *pushButton;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_2;

    void setupUi(QMainWindow *ex6)
    {
        if (ex6->objectName().isEmpty())
            ex6->setObjectName(QString::fromUtf8("ex6"));
        ex6->resize(549, 95);
        centralWidget = new QWidget(ex6);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        horizontalLayout = new QHBoxLayout(centralWidget);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        lcdNumber = new MyQLCDNumber(centralWidget);
        lcdNumber->setObjectName(QString::fromUtf8("lcdNumber"));

        horizontalLayout->addWidget(lcdNumber);

        horizontalSlider = new MySlider(centralWidget);
        horizontalSlider->setObjectName(QString::fromUtf8("horizontalSlider"));
        horizontalSlider->setOrientation(Qt::Horizontal);

        horizontalLayout->addWidget(horizontalSlider);

        pushButton = new QPushButton(centralWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        horizontalLayout->addWidget(pushButton);

        horizontalSpacer = new QSpacerItem(143, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);

        pushButton_2 = new QPushButton(centralWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        horizontalLayout->addWidget(pushButton_2);

        ex6->setCentralWidget(centralWidget);

        retranslateUi(ex6);
        QObject::connect(pushButton_2, SIGNAL(clicked()), ex6, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), horizontalSlider, SLOT(posaZero()));
        QObject::connect(pushButton, SIGNAL(clicked()), lcdNumber, SLOT(posaZero()));
        QObject::connect(horizontalSlider, SIGNAL(valueChanged(int)), lcdNumber, SLOT(base3(int)));

        QMetaObject::connectSlotsByName(ex6);
    } // setupUi

    void retranslateUi(QMainWindow *ex6)
    {
        ex6->setWindowTitle(QApplication::translate("ex6", "ex6", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex6", "Zero", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex6", "&Surt", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex6: public Ui_ex6 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX6_H
