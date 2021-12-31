/********************************************************************************
** Form generated from reading UI file 'ex8.ui'
**
** Created
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EX8_H
#define UI_EX8_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLineEdit>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>
#include <myqtextedit.h>

QT_BEGIN_NAMESPACE

class Ui_ex8
{
public:
    QHBoxLayout *horizontalLayout_2;
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout;
    QSpinBox *spinBox;
    QLineEdit *lineEdit;
    MyQTextEdit *textEdit;
    QVBoxLayout *verticalLayout_2;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QSpacerItem *verticalSpacer;
    QPushButton *pushButton_3;

    void setupUi(QWidget *ex8)
    {
        if (ex8->objectName().isEmpty())
            ex8->setObjectName(QString::fromUtf8("ex8"));
        ex8->resize(528, 249);
        horizontalLayout_2 = new QHBoxLayout(ex8);
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        verticalLayout = new QVBoxLayout();
        verticalLayout->setSpacing(6);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        spinBox = new QSpinBox(ex8);
        spinBox->setObjectName(QString::fromUtf8("spinBox"));

        horizontalLayout->addWidget(spinBox);

        lineEdit = new QLineEdit(ex8);
        lineEdit->setObjectName(QString::fromUtf8("lineEdit"));

        horizontalLayout->addWidget(lineEdit);


        verticalLayout->addLayout(horizontalLayout);

        textEdit = new MyQTextEdit(ex8);
        textEdit->setObjectName(QString::fromUtf8("textEdit"));

        verticalLayout->addWidget(textEdit);


        horizontalLayout_2->addLayout(verticalLayout);

        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        pushButton = new QPushButton(ex8);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));

        verticalLayout_2->addWidget(pushButton);

        pushButton_2 = new QPushButton(ex8);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));

        verticalLayout_2->addWidget(pushButton_2);

        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout_2->addItem(verticalSpacer);

        pushButton_3 = new QPushButton(ex8);
        pushButton_3->setObjectName(QString::fromUtf8("pushButton_3"));

        verticalLayout_2->addWidget(pushButton_3);


        horizontalLayout_2->addLayout(verticalLayout_2);


        retranslateUi(ex8);
        QObject::connect(pushButton_3, SIGNAL(clicked()), ex8, SLOT(close()));
        QObject::connect(spinBox, SIGNAL(valueChanged(QString)), textEdit, SLOT(getNum(QString)));
        QObject::connect(lineEdit, SIGNAL(textEdited(QString)), textEdit, SLOT(getText(QString)));
        QObject::connect(pushButton, SIGNAL(clicked()), textEdit, SLOT(appendCompra()));
        QObject::connect(pushButton_2, SIGNAL(clicked()), textEdit, SLOT(undo()));

        QMetaObject::connectSlotsByName(ex8);
    } // setupUi

    void retranslateUi(QWidget *ex8)
    {
        ex8->setWindowTitle(QApplication::translate("ex8", "ex8", 0, QApplication::UnicodeUTF8));
        pushButton->setText(QApplication::translate("ex8", "Confirm", 0, QApplication::UnicodeUTF8));
        pushButton_2->setText(QApplication::translate("ex8", "Undo", 0, QApplication::UnicodeUTF8));
        pushButton_3->setText(QApplication::translate("ex8", "Quit", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ex8: public Ui_ex8 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EX8_H
