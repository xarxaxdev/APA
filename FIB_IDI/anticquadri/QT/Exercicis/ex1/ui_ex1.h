/********************************************************************************
** Form generated from reading UI file 'ex1.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX1_H
#define UI_EX1_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSlider>
#include <QtGui/QSpacerItem>
#include <QtGui/QWidget>
#include <myqlcdnumber.h>

QT_BEGIN_NAMESPACE

class Ui_ex1
{
public:
    QWidget *centralWidget;
    QHBoxLayout *horizontalLayout;
    MyQLCDNumber *lcdNumber;
    QSlider *horizontalSlider;
    QPushButton *pushButton;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_2;

    void setupUi(QMainWindow *ex1)
    {
        if (ex1->objectName().isEmpty())
            ex1->setObjectName(QString::fromUtf8("ex1"));
        ex1->resize(555, 123);
        centralWidget = new QWidget(ex1);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        horizontalLayout = new QHBoxLayout(centralWidget);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        lcdNumber = new MyQLCDNumber(centralWidget);
        lcdNumber->setObjectName(QString::fromUtf8("lcdNumber"));
        lcdNumber->setStyleSheet(QString::fromUtf8("color: rgba(0,255,0,255)"));

        horizontalLayout->addWidget(lcdNumber);

        horizontalSlider = new QSlider(centralWidget);
        horizontalSlider->setObjectName(QString::fromUtf8("horizontalSlider"));
        horizontalSlider->setOrientation(Qt::Horizontal);

        horizontalLayout->addWidget(horizontalSlider);

        pushButton = new QPushButton(centralWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        horizontalLayout->addWidget(pushButton);

        horizontalSpacer = new QSpacerItem(146, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);

        pushButton_2 = new QPushButton(centralWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        horizontalLayout->addWidget(pushButton_2);

        ex1->setCentralWidget(centralWidget);

        retranslateUi(ex1);
        QObject::connect(pushButton_2, SIGNAL(clicked()), ex1, SLOT(close()));
        QObject::connect(pushButton, SIGNAL(clicked()), lcdNumber, SLOT(displayZero()));
        QObject::connect(horizontalSlider, SIGNAL(valueChanged(int)), lcdNumber, SLOT(changeValueColor(int)));

        QMetaObject::connectSlotsByName(ex1);
    } // setupUi

    void retranslateUi(QMainWindow *ex1)
    {
        ex1->setWindowTitle(QApplication::translate("ex1", "ex1", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex1", "Zero", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex1", "&Surt", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex1: public Ui_ex1 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX1_H
