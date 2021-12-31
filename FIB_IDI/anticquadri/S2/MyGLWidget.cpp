#include <GL/glew.h>
#include "MyGLWidget.h"

#include <iostream>

MyGLWidget::MyGLWidget (QGLFormat &f, QWidget* parent) : QGLWidget(f, parent)
{
  setFocusPolicy(Qt::ClickFocus);  // per rebre events de teclat
}

void MyGLWidget::initializeGL ()
{
  // glew és necessari per cridar funcions de les darreres versions d'OpenGL
  glewExperimental = GL_TRUE;
  glewInit(); 
  glGetError();  // Reinicia la variable d'error d'OpenGL

  glClearColor (0.5, 0.7, 1.0, 1.0); // defineix color de fons (d'esborrat)

  createBuffers();
}

void MyGLWidget::paintGL ()
{
  glClear (GL_COLOR_BUFFER_BIT);  // Esborrem el frame-buffer

  // Activem l'Array a pintar 
  glBindVertexArray(VAO);
 
  // Pintem l'escena
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
  
  // Desactivem el VAO
  glBindVertexArray(0);
}

void MyGLWidget::resizeGL (int w, int h)
{
  glViewport (0, 0, w, h);
}

void MyGLWidget::createBuffers ()
{
    //carregar vertex i fragment shader
    QGLShader fs(QGLShader::Fragment,this);
    fs.compileSourceFile("./FS.frag");
    QGLShader vs(QGLShader::Vertex,this)  ;
    vs.compileSourceFile("./VS.ver");

   //  uint* program;
   QGLShaderProgram* program= new QGLShaderProgram(this);
   program->addShader(&fs);
   program->addShader(&vs);
   program->link();
   program->bind();
   int  pos= glGetAttribLocation(program->programId(),"vertex");
   int  col= glGetAttribLocation(program->programId(),"color");

  glm::vec3 Vertices[3];  // Tres vèrtexs amb X, Y i Z
  Vertices[0] = glm::vec3(1, -1.0, 0.0);
  Vertices[1] = glm::vec3(-1, -1.0, 0.0);
  Vertices[2] = glm::vec3(0.0, 0.0, 0.0);


  // Creació del Vertex Array Object (VAO) que usarem per pintar
  glGenVertexArrays(1, &VAO);
  glBindVertexArray(VAO);

  // Creació del buffer amb les dades dels vèrtexs
  glGenBuffers(1, &VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, (sizeof(Vertices)), Vertices, GL_STATIC_DRAW);
  // Activem l'atribut que farem servir per vèrtex (només el 0 en aquest cas)
  glVertexAttribPointer(pos, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(pos);
  //vertext colors
  static glm::vec3 color[3];
  color[0] = glm::vec3(1.0, 0.0, 0.0); //color rojo
  color[1] = glm::vec3(0.0, 1.0, 0.0); //color verde
  color[2] = glm::vec3(0.0, 0.0, 1.0); //color azul

  //crear buffer
  glGenBuffers(1, &VBO2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO2);
  glBufferData(GL_ARRAY_BUFFER, (sizeof(color)), color,GL_STATIC_DRAW);
  // 2nd attribute buffer : colors
  glVertexAttribPointer( col, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(col);





  // Desactivem el VAO
  glBindVertexArray(0);
}

