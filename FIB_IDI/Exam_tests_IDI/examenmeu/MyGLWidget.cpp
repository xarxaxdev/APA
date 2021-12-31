#include "MyGLWidget.h"
#include"glm/gtc/matrix_inverse.hpp"

#include <iostream>

MyGLWidget::MyGLWidget (QWidget* parent) : QOpenGLWidget(parent)
{
  setFocusPolicy(Qt::ClickFocus);  // per rebre events de teclat
  xClick = yClick = 0;
  angleY = M_PI/4.0;
  perspectiva = true;
  DoingInteractive = NONE;
  radiEsc = sqrt(80);
  FOV= float(M_PI)/3;
  rw=float(width())/float(height());
  color=1;
  desplpilota=0;

}
void MyGLWidget::resizeGL (int w, int h)
{
    float rv=float(w)/float(h);

   if(rv<1){
       //augmentar FOV
       float ang = (atan(tan(M_PI/6.0f)/rw));
       rw = rv;
       FOV=2*ang;
   }
   else{
       rw=rv;
   }
   projectTransform();
 glViewport(0, 0, w, h);
}


MyGLWidget::~MyGLWidget ()
{
  if (program != NULL)
    delete program;
}

void MyGLWidget::initializeGL ()
{
  // Cal inicialitzar l'ús de les funcions d'OpenGL
  initializeOpenGLFunctions();  

  glClearColor(0.5, 0.7, 1.0, 1.0); // defineix color de fons (d'esborrat)
  glEnable(GL_DEPTH_TEST);
  carregaShaders();
  createBuffersPatricio();
  createBuffersPilota();
  createBuffersPorteria();
  createBuffersTerra();
  projectTransform ();
  viewTransform ();
}

void MyGLWidget::paintGL () 
{
  // Esborrem el frame-buffer i el depth-buffer
  glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  // Activem el VAO per a pintar el terra 
  glBindVertexArray (VAO_Terra);

  modelTransformIdent ();
  // pintem terra
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

  // Activem el VAO per a pintar la porteria 
  glBindVertexArray (VAO_Porteria);

  modelTransformIdent ();
  // pintem porteria
  glDrawArrays(GL_TRIANGLES, 0, 66);

  // Activem el VAO per a pintar el Patricio
  glBindVertexArray (VAO_Patr);

  modelTransformPatricio ();
  // Pintem Patricio
  glDrawArrays(GL_TRIANGLES, 0, patr.faces().size()*3);
  
  glBindVertexArray (VAO_Pil);

  modelTransformPilota ();
  // Pintem Pilota
  glDrawArrays(GL_TRIANGLES, 0, pil.faces().size()*3);
  
  glBindVertexArray(0);
}


void MyGLWidget::modelTransformPatricio ()
{
  glm::mat4 TG(1.f);  // Matriu de transformació
  TG = glm::translate(TG, glm::vec3(8,0,0 ));
  TG= glm ::rotate(TG, - float(M_PI)/2.f, glm::vec3(0,1,0)) ;
  TG = glm::scale(TG, glm::vec3(escalaPat, escalaPat, escalaPat));

  TG = glm::translate(TG, -centreBasePat);
  
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}

void MyGLWidget::modelTransformPilota ()
{
  glm::mat4 TG(1.f);  // Matriu de transformació
  TG = glm::translate(TG, glm::vec3(-desplpilota,0,0));
  TG = glm::translate(TG, glm::vec3(5.0, 0.0, 0.0));
  TG = glm::scale(TG, glm::vec3(escalaPil, escalaPil, escalaPil));
  TG = glm::translate(TG, -centreBasePil);
  
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}

void MyGLWidget::modelTransformIdent ()
{
  glm::mat4 TG(1.f);  // Matriu de transformació
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}

void MyGLWidget::projectTransform ()
{
  glm::mat4 Proj;  // Matriu de projecció
  if (perspectiva)
    Proj = glm::perspective(FOV, rw, radiEsc, 3.0f*radiEsc);
  else
    Proj = glm::ortho(-radiEsc, radiEsc, -radiEsc, radiEsc, radiEsc, 3.0f*radiEsc);

  glUniformMatrix4fv (projLoc, 1, GL_FALSE, &Proj[0][0]);
}

void MyGLWidget::viewTransform ()
{
  glm::mat4 View;  // Matriu de posició i orientació
  View = glm::translate(glm::mat4(1.f), glm::vec3(0, 0, -2*radiEsc));
  View = glm::rotate(View, -angleY, glm::vec3(0, 1, 0));
  View= glm :: rotate(View, -angleX,glm::vec3(1,0,0));


  glUniformMatrix4fv (viewLoc, 1, GL_FALSE, &View[0][0]);
}

void MyGLWidget::createBuffersPatricio ()
{
  // Carreguem el model de l'OBJ - Atenció! Abans de crear els buffers!
  patr.load("./models/legoman.obj");

  // Calculem la capsa contenidora del model
  calculaCapsaModel (patr, escalaPat, centreBasePat);
  
  // Creació del Vertex Array Object del Patricio
  glGenVertexArrays(1, &VAO_Patr);
  glBindVertexArray(VAO_Patr);

  // Creació dels buffers del model patr
  // Buffer de posicions
  glGenBuffers(1, &VBO_PatrPos);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3*3, patr.VBO_vertices(), GL_STATIC_DRAW);

  // Activem l'atribut vertexLoc
  glVertexAttribPointer(vertexLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(vertexLoc);

  // Buffer de normals
  glGenBuffers(1, &VBO_PatrNorm);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrNorm);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3*3, patr.VBO_normals(), GL_STATIC_DRAW);

  glVertexAttribPointer(normalLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(normalLoc);

  // En lloc del color, ara passem tots els paràmetres dels materials
  // Buffer de component ambient
  glGenBuffers(1, &VBO_PatrMatamb);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatamb);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3*3, patr.VBO_matamb(), GL_STATIC_DRAW);

  glVertexAttribPointer(matambLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matambLoc);

  // Buffer de component difusa
  glGenBuffers(1, &VBO_PatrMatdiff);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatdiff);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3*3, patr.VBO_matdiff(), GL_STATIC_DRAW);

  glVertexAttribPointer(matdiffLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matdiffLoc);

  // Buffer de component especular
  glGenBuffers(1, &VBO_PatrMatspec);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatspec);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3*3, patr.VBO_matspec(), GL_STATIC_DRAW);

  glVertexAttribPointer(matspecLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matspecLoc);

  // Buffer de component shininness
  glGenBuffers(1, &VBO_PatrMatshin);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatshin);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*patr.faces().size()*3, patr.VBO_matshin(), GL_STATIC_DRAW);

  glVertexAttribPointer(matshinLoc, 1, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matshinLoc);

  glBindVertexArray(0);
}

void MyGLWidget::createBuffersPilota ()
{
  // Carreguem el model de l'OBJ - Atenció! Abans de crear els buffers!
  pil.load("./models/Pilota.obj");

  // Calculem la capsa contenidora del model
  calculaCapsaModel (pil, escalaPil, centreBasePil);
  
  // Creació del Vertex Array Object del Patricio
  glGenVertexArrays(1, &VAO_Pil);
  glBindVertexArray(VAO_Pil);

  // Creació dels buffers del model patr
  // Buffer de posicions
  glGenBuffers(1, &VBO_PilPos);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3*3, pil.VBO_vertices(), GL_STATIC_DRAW);

  // Activem l'atribut vertexLoc
  glVertexAttribPointer(vertexLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(vertexLoc);

  // Buffer de normals
  glGenBuffers(1, &VBO_PilNorm);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilNorm);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3*3, pil.VBO_normals(), GL_STATIC_DRAW);

  glVertexAttribPointer(normalLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(normalLoc);

  // En lloc del color, ara passem tots els paràmetres dels materials
  // Buffer de component ambient
  glGenBuffers(1, &VBO_PilMatamb);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilMatamb);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3*3, pil.VBO_matamb(), GL_STATIC_DRAW);

  glVertexAttribPointer(matambLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matambLoc);

  // Buffer de component difusa
  glGenBuffers(1, &VBO_PilMatdiff);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilMatdiff);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3*3, pil.VBO_matdiff(), GL_STATIC_DRAW);

  glVertexAttribPointer(matdiffLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matdiffLoc);

  // Buffer de component especular
  glGenBuffers(1, &VBO_PilMatspec);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilMatspec);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3*3, pil.VBO_matspec(), GL_STATIC_DRAW);

  glVertexAttribPointer(matspecLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matspecLoc);

  // Buffer de component shininness
  glGenBuffers(1, &VBO_PilMatshin);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PilMatshin);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*pil.faces().size()*3, pil.VBO_matshin(), GL_STATIC_DRAW);

  glVertexAttribPointer(matshinLoc, 1, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matshinLoc);

  glBindVertexArray(0);
}

void MyGLWidget::createBuffersTerra ()
{
  // Dades del terra
  // VBO amb la posició dels vèrtexs
  glm::vec3 posterra[4] = {
        glm::vec3(-10.0, 0.0, -6.0),
        glm::vec3(-10.0, 0.0,  6.0),
        glm::vec3( 10.0, 0.0, -6.0),
        glm::vec3( 10.0, 0.0,  6.0)
  }; 

  // VBO amb la normal de cada vèrtex
  glm::vec3 normt (0,1,0);
  glm::vec3 normterra[4] = {
	normt, normt, normt, normt
  };

  // Definim el material del terra
  glm::vec3 amb(0,0.1,0);
  glm::vec3 diff(0.2,0.6,0.1);
  glm::vec3 spec(0.5,0.5,0.5);
  float shin = 100;

  // Fem que aquest material afecti a tots els vèrtexs per igual
  glm::vec3 matambterra[4] = {
	amb, amb, amb, amb
  };
  glm::vec3 matdiffterra[4] = {
	diff, diff, diff, diff
  };
  glm::vec3 matspecterra[4] = {
	spec, spec, spec, spec
  };
  float matshinterra[4] = {
	shin, shin, shin, shin
  };

// Creació del Vertex Array Object del terra
  glGenVertexArrays(1, &VAO_Terra);
  glBindVertexArray(VAO_Terra);

  glGenBuffers(1, &VBO_TerraPos);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(posterra), posterra, GL_STATIC_DRAW);

  // Activem l'atribut vertexLoc
  glVertexAttribPointer(vertexLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(vertexLoc);

  glGenBuffers(1, &VBO_TerraNorm);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraNorm);
  glBufferData(GL_ARRAY_BUFFER, sizeof(normterra), normterra, GL_STATIC_DRAW);

  // Activem l'atribut normalLoc
  glVertexAttribPointer(normalLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(normalLoc);

  // En lloc del color, ara passem tots els paràmetres dels materials
  // Buffer de component ambient
  glGenBuffers(1, &VBO_TerraMatamb);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraMatamb);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matambterra), matambterra, GL_STATIC_DRAW);

  glVertexAttribPointer(matambLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matambLoc);

  // Buffer de component difusa
  glGenBuffers(1, &VBO_TerraMatdiff);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraMatdiff);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matdiffterra), matdiffterra, GL_STATIC_DRAW);

  glVertexAttribPointer(matdiffLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matdiffLoc);

  // Buffer de component especular
  glGenBuffers(1, &VBO_TerraMatspec);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraMatspec);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matspecterra), matspecterra, GL_STATIC_DRAW);

  glVertexAttribPointer(matspecLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matspecLoc);

  // Buffer de component shininness
  glGenBuffers(1, &VBO_TerraMatshin);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_TerraMatshin);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matshinterra), matshinterra, GL_STATIC_DRAW);

  glVertexAttribPointer(matshinLoc, 1, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matshinLoc);

  glBindVertexArray(0);
}

void MyGLWidget::createBuffersPorteria ()
{
  // Dades de la porteria
  // Vèrtexs de la porteria
  glm::vec3 vertexs[16] = {
       /* 0*/ glm::vec3( -7.0, 0.0,  4.0),  /* 1*/ glm::vec3( -7.0, 0.0,  3.5),
       /* 2*/ glm::vec3( -7.0, 5.5,  3.5),  /* 3*/ glm::vec3( -7.0, 6.0,  4.0),
       /* 4*/ glm::vec3( -7.0, 5.5, -3.5),  /* 5*/ glm::vec3( -7.0, 6.0, -4.0),
       /* 6*/ glm::vec3( -7.0, 0.0, -3.5),  /* 7*/ glm::vec3( -7.0, 0.0, -4.0),
       /* 8*/ glm::vec3(-10.0, 0.0,  3.5),  /* 9*/ glm::vec3( -9.5, 0.0,  3.0),
       /*10*/ glm::vec3(-10.0, 5.5,  3.5),  /*11*/ glm::vec3( -9.5, 5.0,  3.0),
       /*12*/ glm::vec3(-10.0, 0.0, -3.5),  /*13*/ glm::vec3( -9.5, 0.0, -3.0),
       /*14*/ glm::vec3(-10.0, 5.5, -3.5),  /*15*/ glm::vec3( -9.5, 5.0, -3.0)
  };

  //el radi de l'escena serà el punt més llunyà de la escena, sino pot ser que la retallem en quan girem la camara
  //en aquest cas esta clar que el mes llunya es aquest
    radiEsc= sqrt((10*10) + (5.5*5.5) + (3.5*3.5));
  // VBO amb la posició dels vèrtexs
  glm::vec3 posporteria[66] = {  // 22 triangles
       vertexs[0], vertexs[1], vertexs[2],
       vertexs[0], vertexs[2], vertexs[3],
       vertexs[3], vertexs[2], vertexs[4],
       vertexs[3], vertexs[4], vertexs[5],
       vertexs[5], vertexs[4], vertexs[6],
       vertexs[5], vertexs[6], vertexs[7],
       vertexs[8], vertexs[0], vertexs[3],
       vertexs[8], vertexs[3], vertexs[10],
       vertexs[1], vertexs[9], vertexs[2],
       vertexs[2], vertexs[9], vertexs[11],
       vertexs[7], vertexs[12], vertexs[14],
       vertexs[7], vertexs[14], vertexs[5],
       vertexs[6], vertexs[4], vertexs[15],
       vertexs[6], vertexs[15], vertexs[13],
       vertexs[3], vertexs[5], vertexs[10],
       vertexs[10], vertexs[5], vertexs[14],
       vertexs[2], vertexs[11], vertexs[4],
       vertexs[11], vertexs[15], vertexs[4],
       vertexs[11], vertexs[9], vertexs[13],
       vertexs[11], vertexs[13], vertexs[15],
       vertexs[8], vertexs[10], vertexs[12],
       vertexs[12], vertexs[10], vertexs[14],
  };

  // VBO amb la normal de cada vèrtex
  glm::vec3 normals[10] = {
       /* 0*/ glm::vec3( 1.0, 0.0,  1.0),  /* 1*/ glm::vec3( 1.0, 0.0, -1.0),
       /* 2*/ glm::vec3( 0.0, 0.0,  1.0),  /* 3*/ glm::vec3( 0.0, 0.0, -1.0),
       /* 4*/ glm::vec3( 0.0, 1.0,  0.0),  /* 5*/ glm::vec3( 0.0,-1.0,  0.0),
       /* 6*/ glm::vec3( 1.0, 0.0,  0.0),  /* 7*/ glm::vec3(-1.0, 0.0,  0.0),
       /* 8*/ glm::vec3( 1.0,-1.0,  0.0),  /* 9*/ glm::vec3( 1.0, 1.0,  0.0)
  };
  glm::vec3 normporteria[66] = {
       normals[0], normals[1], normals[1],
       normals[0], normals[1], normals[0],
       normals[9], normals[8], normals[8],
       normals[9], normals[8], normals[9],
       normals[1], normals[0], normals[0],
       normals[1], normals[0], normals[1],
       normals[2], normals[0], normals[0],
       normals[2], normals[0], normals[2],
       normals[1], normals[3], normals[1],
       normals[1], normals[3], normals[3],
       normals[1], normals[3], normals[3],
       normals[1], normals[3], normals[1],
       normals[0], normals[0], normals[2],
       normals[0], normals[2], normals[2],
       normals[4], normals[4], normals[4],
       normals[4], normals[4], normals[4],
       normals[5], normals[5], normals[5],
       normals[5], normals[5], normals[5],
       normals[6], normals[6], normals[6],
       normals[6], normals[6], normals[6],
       normals[7], normals[7], normals[7],
       normals[7], normals[7], normals[7],
  };

  // Definim el material del terra
  glm::vec3 amb(0.1,0.1,0);
  //potser es un magenta molt rosa
  glm::vec3 diff(0.8,0.1,0.8);
  glm::vec3 spec(0.5,0.5,0.5);
  float shin = 0;

  // Fem que aquest material afecti a tots els vèrtexs per igual
  glm::vec3 matambporteria[66] = {
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb,
	amb, amb, amb, amb, amb, amb
  };
  glm::vec3 matdiffporteria[66] = {
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff,
	diff, diff, diff, diff, diff, diff
  };
  glm::vec3 matspecporteria[66] = {
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec,
	spec, spec, spec, spec, spec, spec
  };
  float matshinporteria[66] = {
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin,
	shin, shin, shin, shin, shin, shin
  };

// Creació del Vertex Array Object de la porteria
  glGenVertexArrays(1, &VAO_Porteria);
  glBindVertexArray(VAO_Porteria);

  glGenBuffers(1, &VBO_PorteriaPos);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaPos);
  glBufferData(GL_ARRAY_BUFFER, sizeof(posporteria), posporteria, GL_STATIC_DRAW);

  // Activem l'atribut vertexLoc
  glVertexAttribPointer(vertexLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(vertexLoc);

  glGenBuffers(1, &VBO_PorteriaNorm);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaNorm);
  glBufferData(GL_ARRAY_BUFFER, sizeof(normporteria), normporteria, GL_STATIC_DRAW);

  // Activem l'atribut normalLoc
  glVertexAttribPointer(normalLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(normalLoc);

  // En lloc del color, ara passem tots els paràmetres dels materials
  // Buffer de component ambient
  glGenBuffers(1, &VBO_PorteriaMatamb);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaMatamb);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matambporteria), matambporteria, GL_STATIC_DRAW);

  glVertexAttribPointer(matambLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matambLoc);

  // Buffer de component difusa
  glGenBuffers(1, &VBO_PorteriaMatdiff);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaMatdiff);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matdiffporteria), matdiffporteria, GL_STATIC_DRAW);

  glVertexAttribPointer(matdiffLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matdiffLoc);

  // Buffer de component especular
  glGenBuffers(1, &VBO_PorteriaMatspec);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaMatspec);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matspecporteria), matspecporteria, GL_STATIC_DRAW);

  glVertexAttribPointer(matspecLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matspecLoc);

  // Buffer de component shininness
  glGenBuffers(1, &VBO_PorteriaMatshin);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PorteriaMatshin);
  glBufferData(GL_ARRAY_BUFFER, sizeof(matshinporteria), matshinporteria, GL_STATIC_DRAW);

  glVertexAttribPointer(matshinLoc, 1, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matshinLoc);

  glBindVertexArray(0);
}
void MyGLWidget::carregaShaders()
{
  // Creem els shaders per al fragment shader i el vertex shader
  QOpenGLShader fs (QOpenGLShader::Fragment, this);
  QOpenGLShader vs (QOpenGLShader::Vertex, this);
  // Carreguem el codi dels fitxers i els compilem
  fs.compileSourceFile("shaders/fragshad.frag");
  vs.compileSourceFile("shaders/vertshad.vert");
  // Creem el program
  program = new QOpenGLShaderProgram(this);
  // Li afegim els shaders corresponents
  program->addShader(&fs);
  program->addShader(&vs);
  // Linkem el program
  program->link();
  // Indiquem que aquest és el program que volem usar
  program->bind();

  // Obtenim identificador per a l'atribut “vertex” del vertex shader
  vertexLoc = glGetAttribLocation (program->programId(), "vertex");
  // Obtenim identificador per a l'atribut “normal” del vertex shader
  normalLoc = glGetAttribLocation (program->programId(), "normal");
  // Obtenim identificador per a l'atribut “matamb” del vertex shader
  matambLoc = glGetAttribLocation (program->programId(), "matamb");
  // Obtenim identificador per a l'atribut “matdiff” del vertex shader
  matdiffLoc = glGetAttribLocation (program->programId(), "matdiff");
  // Obtenim identificador per a l'atribut “matspec” del vertex shader
  matspecLoc = glGetAttribLocation (program->programId(), "matspec");
  // Obtenim identificador per a l'atribut “matshin” del vertex shader
  matshinLoc = glGetAttribLocation (program->programId(), "matshin");

  // Demanem identificadors per als uniforms del vertex shader
  transLoc = glGetUniformLocation (program->programId(), "TG");
  projLoc = glGetUniformLocation (program->programId(), "proj");
  viewLoc = glGetUniformLocation (program->programId(), "view");
  color = glGetUniformLocation (program->programId(), "mycolor");
}

void MyGLWidget::calculaCapsaModel (Model &p, float &escala, glm::vec3 &centreBase)
{
  // Càlcul capsa contenidora i valors transformacions inicials
  float minx, miny, minz, maxx, maxy, maxz;
  minx = maxx = p.vertices()[0];
  miny = maxy = p.vertices()[1];
  minz = maxz = p.vertices()[2];
  for (unsigned int i = 3; i < p.vertices().size(); i+=3)
  {
    if (p.vertices()[i+0] < minx)
      minx = p.vertices()[i+0];
    if (p.vertices()[i+0] > maxx)
      maxx = p.vertices()[i+0];
    if (p.vertices()[i+1] < miny)
      miny = p.vertices()[i+1];
    if (p.vertices()[i+1] > maxy)
      maxy = p.vertices()[i+1];
    if (p.vertices()[i+2] < minz)
      minz = p.vertices()[i+2];
    if (p.vertices()[i+2] > maxz)
      maxz = p.vertices()[i+2];
  }
  escala = 4.0/(maxy-miny);
  centreBase[0] = (minx+maxx)/2.0; centreBase[1] = miny; centreBase[2] = (minz+maxz)/2.0;
}

void MyGLWidget::keyPressEvent(QKeyEvent* event) 
{
  makeCurrent();
  switch (event->key()) {
    case Qt::Key_O: { // canvia òptica entre perspectiva i axonomètrica
      perspectiva = !perspectiva;
      projectTransform ();
      break;
    }

  case Qt::Key_Up: { // canvia òptica entre perspectiva i axonomètrica
     if(desplpilota <=12)desplpilota=desplpilota+2;
    //modelTransformPilota();
    if(desplpilota==14)    glUniform1f(color,2);
    break;
  }
  case Qt::Key_I: { // canvia òptica entre perspectiva i axonomètrica
     desplpilota=0;
     //modelTransformPilota();
    glUniform1f(color,1);
    break;
  }
    default: event->ignore(); break;
  }
  update();
}

void MyGLWidget::mousePressEvent (QMouseEvent *e)
{
  xClick = e->x();
  yClick = e->y();

  if (e->button() & Qt::LeftButton &&
      ! (e->modifiers() & (Qt::ShiftModifier|Qt::AltModifier|Qt::ControlModifier)))
  {
    DoingInteractive = ROTATE;
  }
}

void MyGLWidget::mouseReleaseEvent( QMouseEvent *)
{
  DoingInteractive = NONE;
}

void MyGLWidget::mouseMoveEvent(QMouseEvent *e)
{
  makeCurrent();
  // Aqui cal que es calculi i s'apliqui la rotacio o el zoom com s'escaigui...
  if (DoingInteractive == ROTATE)
  {
    // Fem la rotació
    angleY += (e->x() - xClick) * M_PI / 180.0;
    angleX += (e->y() - yClick)* M_PI/180;

    viewTransform ();
  }

  xClick = e->x();
  yClick = e->y();

  update ();
}


void MyGLWidget::reset(){
    makeCurrent();

    desplpilota=0;
    //modelTransformPilota();
   glUniform1f(color,1);
  update ();
}
void MyGLWidget::change(int x){
    //aqui canviaria la shininess
}

