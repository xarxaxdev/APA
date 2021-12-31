TEMPLATE    = app
QT         += opengl

LIBS += -lGLEW
INCLUDEPATH +=  /usr/include/glm

HEADERS += MyGLWidget.h model.h

SOURCES += main.cpp \
        MyGLWidget.cpp \
        model.cpp
        