/********************************************************************************
** Form generated from reading UI file 'ex2.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX2_H
#define UI_EX2_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QLCDNumber>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSlider>
#include <QtGui/QWidget>
#include "MyLabel.h"

QT_BEGIN_NAMESPACE

class Ui_ex2
{
public:
    QWidget *centralWidget;
    QSlider *horizontalSlider;
    QSlider *horizontalSlider_2;
    QSlider *horizontalSlider_3;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QLabel *label;
    QLabel *label_2;
    QLabel *label_3;
    QLCDNumber *lcdNumber;
    QLCDNumber *lcdNumber_2;
    QLCDNumber *lcdNumber_3;
    MyLabel *label_4;

    void setupUi(QMainWindow *ex2)
    {
        if (ex2->objectName().isEmpty())
            ex2->setObjectName(QString::fromUtf8("ex2"));
        ex2->resize(541, 344);
        centralWidget = new QWidget(ex2);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        horizontalSlider = new QSlider(centralWidget);
        horizontalSlider->setObjectName(QString::fromUtf8("horizontalSlider"));
        horizontalSlider->setGeometry(QRect(60, 210, 151, 22));
        horizontalSlider->setMaximum(255);
        horizontalSlider->setOrientation(Qt::Horizontal);
        horizontalSlider_2 = new QSlider(centralWidget);
        horizontalSlider_2->setObjectName(QString::fromUtf8("horizontalSlider_2"));
        horizontalSlider_2->setGeometry(QRect(60, 240, 151, 22));
        horizontalSlider_2->setMaximum(255);
        horizontalSlider_2->setOrientation(Qt::Horizontal);
        horizontalSlider_3 = new QSlider(centralWidget);
        horizontalSlider_3->setObjectName(QString::fromUtf8("horizontalSlider_3"));
        horizontalSlider_3->setGeometry(QRect(60, 270, 151, 22));
        horizontalSlider_3->setMaximum(255);
        horizontalSlider_3->setOrientation(Qt::Horizontal);
        pushButton = new QPushButton(centralWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));
        pushButton->setGeometry(QRect(340, 270, 60, 32));
        pushButton_2 = new QPushButton(centralWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));
        pushButton_2->setGeometry(QRect(440, 270, 69, 32));
        label = new QLabel(centralWidget);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(30, 210, 16, 16));
        label_2 = new QLabel(centralWidget);
        label_2->setObjectName(QString::fromUtf8("label_2"));
        label_2->setGeometry(QRect(30, 240, 16, 16));
        label_3 = new QLabel(centralWidget);
        label_3->setObjectName(QString::fromUtf8("label_3"));
        label_3->setGeometry(QRect(30, 270, 16, 16));
        lcdNumber = new QLCDNumber(centralWidget);
        lcdNumber->setObjectName(QString::fromUtf8("lcdNumber"));
        lcdNumber->setGeometry(QRect(240, 210, 64, 23));
        lcdNumber_2 = new QLCDNumber(centralWidget);
        lcdNumber_2->setObjectName(QString::fromUtf8("lcdNumber_2"));
        lcdNumber_2->setGeometry(QRect(240, 240, 64, 23));
        lcdNumber_3 = new QLCDNumber(centralWidget);
        lcdNumber_3->setObjectName(QString::fromUtf8("lcdNumber_3"));
        lcdNumber_3->setGeometry(QRect(240, 270, 64, 23));
        label_4 = new MyLabel(centralWidget);
        label_4->setObjectName(QString::fromUtf8("label_4"));
        label_4->setGeometry(QRect(21, 15, 491, 181));
        ex2->setCentralWidget(centralWidget);

        retranslateUi(ex2);
        QObject::connect(pushButton_2, SIGNAL(clicked()), ex2, SLOT(close()));
        QObject::connect(horizontalSlider, SIGNAL(valueChanged(int)), lcdNumber, SLOT(display(int)));
        QObject::connect(horizontalSlider_2, SIGNAL(valueChanged(int)), lcdNumber_2, SLOT(display(int)));
        QObject::connect(horizontalSlider_3, SIGNAL(valueChanged(int)), lcdNumber_3, SLOT(display(int)));
        QObject::connect(horizontalSlider, SIGNAL(valueChanged(int)), label_4, SLOT(saveR(int)));
        QObject::connect(horizontalSlider_2, SIGNAL(valueChanged(int)), label_4, SLOT(saveG(int)));
        QObject::connect(horizontalSlider_3, SIGNAL(valueChanged(int)), label_4, SLOT(saveB(int)));
        QObject::connect(pushButton, SIGNAL(clicked()), label_4, SLOT(setColor()));

        QMetaObject::connectSlotsByName(ex2);
    } // setupUi

    void retranslateUi(QMainWindow *ex2)
    {
        ex2->setWindowTitle(QApplication::translate("ex2", "ex2", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex2", "Ok", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex2", "&Quit", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("ex2", "R", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("ex2", "G", 0, QApplication::UnicodeUTF8));
        label_3->setText(QApplication::translate("ex2", "B", 0, QApplication::UnicodeUTF8));
        label_4->setText(QString());
    } // retranslateUi

};

namespace Ui {
    class ex2: public Ui_ex2 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX2_H
