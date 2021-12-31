#ifndef _ANIMATEVERTICES_H
#define _ANIMATEVERTICES_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QElapsedTimer>
#include <QTime>
#include <QWidget>


class Animatevertices : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void preFrame();
    void postFrame();
    
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader *fs, *vs; 
    QElapsedTimer elapsedTimer;
    QTime timer;
 };
 
 #endif
