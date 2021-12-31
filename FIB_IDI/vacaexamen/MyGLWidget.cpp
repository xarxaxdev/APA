#include "MyGLWidget.h"

#include <iostream>
#include <cmath>
#include"glm/gtc/matrix_inverse.hpp"

MyGLWidget::MyGLWidget (QWidget* parent) : QOpenGLWidget(parent)
{
  setFocusPolicy(Qt::ClickFocus);  // per rebre events de teclat
  xClick = yClick = 0;
  angleY = 0.0;
  angleX = 0.0;
  perspectiva = true;
  DoingInteractive = NONE;
  //radiEsc = sqrt(9);
  valormodelllum=0;
  radiEsc=1;
   //FOVantic=(float)M_PI/4.0f;
  //teoricament hauria de ser 60 graus que es M_PI/3
  FOV=(float)M_PI/3.0f;
  rw=float(width())/float(height());
   rotacio=0;
   mode =0;
}

void MyGLWidget::resizeGL (int w, int h)
{
     float rv=float(w)/float(h);

    if(rv<1){
        //augmentar FOV
        float ang = (atan(tan(M_PI/6.0f)/rw));
        rw = rv;

        FOV=2*ang;
        std::cout << "nueva anchura menor, angulo " << FOV  << std::endl;
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
    rw=float(width())/float(height());
    oldh=height();
    oldw=width();
    std::cout << "startw " << oldw  << std::endl;
    std::cout << "starth " << oldh  << std::endl;
  initializeOpenGLFunctions();  

  glClearColor(0.5, 0.7, 1.0, 1.0); // defineix color de fons (d'esborrat)
  glEnable(GL_DEPTH_TEST);//no pinta els pixels tapats,gasta més memoria
  //activar face-culling
  //glEnable(GL_CULL_FACE);
  //glCullFace(GL_FRONT);//per defecte es GL_BACK, depen de si volem amagar la cara o el cul del triangle
  carregaShaders();
  createBuffers();
  projectTransform ();
  //radiEsc=sqrt((centrePatr[0]/2) - 3);

  viewTransform ();
}

void MyGLWidget::paintGL () 
{
  // Esborrem el frame-buffer i el depth-buffer
  glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);//aixo es pel DEPTH buffer, com el glEnable anterior

  // Activem el VAO per a pintar el terra 
  glBindVertexArray (VAO_Terra);

  modelTransformTerra ();

  // pintem
  glDrawArrays(GL_TRIANGLES, 0, 12);

  // Activem el VAO per a pintar la vaca
  glBindVertexArray (VAO_Patr);

  modelTransformPatricio ();

  glDrawArrays(GL_TRIANGLES, 0, patr.faces().size()*3);

  // pintem el patricio
    glBindVertexArray(VAO_Patr2);
    modelTransformPatricio2();

    glDrawArrays(GL_TRIANGLES, 0, realpatr.faces().size()*3);


  glBindVertexArray(0);
}


void MyGLWidget::createBuffers ()
{
  // Carreguem el model de l'OBJ - Atenció! Abans de crear els buffers!
  patr.load("./models/cow.obj");
  realpatr.load("./models/Patricio.obj");

  // Calculem la capsa contenidora del model
  calculaCapsaModel();

  calculaCapsaModel2();
  ///// patricio

  // Creació del Vertex Array Object del Patricio
  glGenVertexArrays(1, &VAO_Patr2);
  glBindVertexArray(VAO_Patr2);
  // Creació dels buffers del model patr
  // Buffer de posicions
  glGenBuffers(1, &VBO_PatrPos2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrPos2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3*3, realpatr.VBO_vertices(), GL_STATIC_DRAW);

  // Activem l'atribut vertexLoc
  glVertexAttribPointer(vertexLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(vertexLoc);

  // Buffer de normals
  glGenBuffers(1, &VBO_PatrNorm2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrNorm2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3*3, realpatr.VBO_normals(), GL_STATIC_DRAW);

  glVertexAttribPointer(normalLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(normalLoc);

  // En lloc del color, ara passem tots els paràmetres dels materials
  // Buffer de component ambient
  glGenBuffers(1, &VBO_PatrMatamb2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatamb2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3*3, realpatr.VBO_matamb(), GL_STATIC_DRAW);

  glVertexAttribPointer(matambLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matambLoc);

  // Buffer de component difusa
  glGenBuffers(1, &VBO_PatrMatdiff2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatdiff2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3*3, realpatr.VBO_matdiff(), GL_STATIC_DRAW);

  glVertexAttribPointer(matdiffLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matdiffLoc);

  // Buffer de component especular
  glGenBuffers(1, &VBO_PatrMatspec2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatspec2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3*3, realpatr.VBO_matspec(), GL_STATIC_DRAW);

  glVertexAttribPointer(matspecLoc, 3, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matspecLoc);

  // Buffer de component shininness
  glGenBuffers(1, &VBO_PatrMatshin2);
  glBindBuffer(GL_ARRAY_BUFFER, VBO_PatrMatshin2);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*realpatr.faces().size()*3, realpatr.VBO_matshin(), GL_STATIC_DRAW);

  glVertexAttribPointer(matshinLoc, 1, GL_FLOAT, GL_FALSE, 0, 0);
  glEnableVertexAttribArray(matshinLoc);

 ///// vaca
  
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



  // Dades del terra
  // VBO amb la posició dels vèrtexs
  glm::vec3 posterra[12] = {
	glm::vec3(-2.0, -1.0, 2.0),
	glm::vec3(2.0, -1.0, 2.0),
	glm::vec3(-2.0, -1.0, -2.0),
	glm::vec3(-2.0, -1.0, -2.0),
	glm::vec3(2.0, -1.0, 2.0),
	glm::vec3(2.0, -1.0, -2.0),
	glm::vec3(-2.0, -1.0, -2.0),
	glm::vec3(2.0, -1.0, -2.0),
	glm::vec3(-2.0, 1.0, -2.0),
	glm::vec3(-2.0, 1.0, -2.0),
	glm::vec3(2.0, -1.0, -2.0),
	glm::vec3(2.0, 1.0, -2.0)
  }; 

  // VBO amb la normal de cada vèrtex
  glm::vec3 norm1 (0,1,0);
  glm::vec3 norm2 (0,0,1);
  glm::vec3 normterra[12] = {
	norm1, norm1, norm1, norm1, norm1, norm1, // la normal (0,1,0) per als primers dos triangles
	norm2, norm2, norm2, norm2, norm2, norm2  // la normal (0,0,1) per als dos últims triangles
  };

  // Definim el material del terra
  glm::vec3 amb(0.2,0,0.2);
  glm::vec3 diff(0.8,0,0.8);
  glm::vec3 spec(0,0,0);
  float shin = 100;

  // Fem que aquest material afecti a tots els vèrtexs per igual
  glm::vec3 matambterra[12] = {
	amb, amb, amb, amb, amb, amb, amb, amb, amb, amb, amb, amb
  };
  glm::vec3 matdiffterra[12] = {
	diff, diff, diff, diff, diff, diff, diff, diff, diff, diff, diff, diff
  };
  glm::vec3 matspecterra[12] = {
	spec, spec, spec, spec, spec, spec, spec, spec, spec, spec, spec, spec
  };
  float matshinterra[12] = {
	shin, shin, shin, shin, shin, shin, shin, shin, shin, shin, shin, shin
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

  //afegit un control per representar amb un model de color o un altre
  modelllum= glGetUniformLocation(program-> programId(),"modelllum");
  //aquesta es la matriu que s'ha de multiplicar per passar de
  //SCA a SCO(la inversa transposada)
  mode=glGetUniformLocation(program->programId(),"mode");
}

void MyGLWidget::modelTransformPatricio ()
{
  TG = glm::mat4 (1.f);  // Matriu de transformació
  TG = glm::translate(TG, glm::vec3(1,-0.75,0));
  TG =glm::rotate(TG,rotacio,glm::vec3(0,1,0));
  TG = glm::scale(TG, glm::vec3(escala, escala, escala));
    TG = glm::rotate(TG, float(M_PI/2),glm::vec3(0,-1,0));
  TG = glm::rotate(TG, float(M_PI/2),glm::vec3(-1,0,0));
  TG = glm::translate(TG, -centrePatr);
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}
void MyGLWidget::modelTransformPatricio2 ()
{
  TG = glm::mat4 (1.f);  // Matriu de transformació
  TG = glm::translate(TG,glm::vec3(1,(-0.5+0.125),0));
  TG =glm::rotate(TG,rotacio,glm::vec3(0,1,0));

  TG = glm::scale(TG, glm::vec3(escalapatr, escalapatr, escalapatr));
  TG = glm::translate(TG, -centrerealPatr);
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}

void MyGLWidget::modelTransformTerra ()
{
  glm::mat4 TG(1.f);  // Matriu de transformació
  glUniformMatrix4fv (transLoc, 1, GL_FALSE, &TG[0][0]);
}

void MyGLWidget::projectTransform ()
{
  glm::mat4 Proj;  // Matriu de projecció
  if (perspectiva)
      //znear== 0 ->Apocalipsi
    Proj = glm::perspective(FOV, rw, 0.1f, 50.0f);
  else
    Proj = glm::ortho(-radiEsc, radiEsc, -radiEsc, radiEsc, radiEsc, 3.0f*radiEsc);

  glUniformMatrix4fv (projLoc, 1, GL_FALSE, &Proj[0][0]);
}

void MyGLWidget::viewTransform ()
{
    View = glm::lookAt(glm::vec3(-1.0f, 1.0f, -1.0f),
               glm::vec3(0.0f, 0.0f, 0.0f),
               glm::vec3(0.0f, 1.0f, 0.0f));
  //glm::mat4 View;  // Matriu de posició i orientació
  //View = glm::translate(glm::mat4(1.f), glm::vec3(0, 0, -2*radiEsc));
  //View = glm::rotate(View, -angleY, glm::vec3(0, 1, 0));
  //View= glm :: rotate(View, -angleX,glm::vec3(1,0,0));
  //glm::mat3 normSCO=glm::inverseTranspose(glm::mat3(View*TG));

  glUniformMatrix4fv (viewLoc, 1, GL_FALSE, &View[0][0]);
}

int abs(int a){
    if(a<0)return -a;
    return a;
}
int max(int a,int b){
    if(a<b)return b;
    return a;
}

float radiesc(Model m){
    //aquesta funcio retorna el radi que fa falta de escena per incloure aquest objecte
    //en l'escena(suposant que esta centrada a l'origen

    float minx, miny, minz, maxx, maxy, maxz;
    minx = maxx = m.vertices()[0];
    miny = maxy = m.vertices()[1];
    minz = maxz = m.vertices()[2];
    for (unsigned int i = 3; i < m.vertices().size(); i+=3)
    {
      if (m.vertices()[i+0] < minx)
        minx = m.vertices()[i+0];
      if (m.vertices()[i+0] > maxx)
        maxx = m.vertices()[i+0];
      if (m.vertices()[i+1] < miny)
        miny = m.vertices()[i+1];
      if (m.vertices()[i+1] > maxy)
        maxy = m.vertices()[i+1];
      if (m.vertices()[i+2] < minz)
        minz = m.vertices()[i+2];
      if (m.vertices()[i+2] > maxz)
        maxz = m.vertices()[i+2];
    }
    //abs retorna valor absolut
    float rmaxx=max(abs(maxx),abs(minx)), rmaxy=max(abs(maxy),abs(miny)),
            rmaxz=max(abs(maxz),abs(minz));

    return sqrt((rmaxx*rmaxx)+(rmaxy*rmaxy)+(rmaxz*rmaxz));

}

void MyGLWidget::calculaCapsaModel ()
{
  // Càlcul capsa contenidora i valors transformacions inicials
  float minx, miny, minz, maxx, maxy, maxz;
  minx = maxx = patr.vertices()[0];
  miny = maxy = patr.vertices()[1];
  minz = maxz = patr.vertices()[2];
  for (unsigned int i = 3; i < patr.vertices().size(); i+=3)
  {
    if (patr.vertices()[i+0] < minx)
      minx = patr.vertices()[i+0];
    if (patr.vertices()[i+0] > maxx)
      maxx = patr.vertices()[i+0];
    if (patr.vertices()[i+1] < miny)
      miny = patr.vertices()[i+1];
    if (patr.vertices()[i+1] > maxy)
      maxy = patr.vertices()[i+1];
    if (patr.vertices()[i+2] < minz)
      minz = patr.vertices()[i+2];
    if (patr.vertices()[i+2] > maxz)
      maxz = patr.vertices()[i+2];
  }
  //en veritat el diametre esta mal calculat, cada component s'hauria de multiplicar per l'escala dos cops
  //llavors hauriem de acumular el maxim
  //aquest seria en veritat el diametre del patricio sense escalar

   //std::cout << acos(1/2) << std::endl;
   //la  vaca esta girada originalment
  escala = 0.5/(maxz-minz);
  //float a=radiesc(patr);
  //multiplico per
  float xorig= escala*(maxx-minx)/2,   zorig=escala*(maxz - minz)/2;//distancia de la x al origen
  std::cout << "xorig" << xorig << std::endl;
  //float a = sqrt(((maxx-minx)*(maxx-minx)*escala*escala/4)+ 9 + ((maxz-minz)*(maxz-minz)*escala*escala)/4);
  float a = sqrt( 9 + xorig*xorig + zorig*zorig);

  if(a>radiEsc)
          radiEsc= a;//posa un valor adequat al radi de la escena
  centrePatr[0] = (minx+maxx)/2.0; centrePatr[1] = (miny+maxy)/2.0; centrePatr[2] = (minz+maxz)/2.0;
}
void MyGLWidget::calculaCapsaModel2()
{
  // Càlcul capsa contenidora i valors transformacions inicials
  float minx, miny, minz, maxx, maxy, maxz;
  minx = maxx = realpatr.vertices()[0];
  miny = maxy = realpatr.vertices()[1];
  minz = maxz = realpatr.vertices()[2];
  for (unsigned int i = 3; i < realpatr.vertices().size(); i+=3)
  {
    if (realpatr.vertices()[i+0] < minx)
      minx = realpatr.vertices()[i+0];
    if (realpatr.vertices()[i+0] > maxx)
      maxx = realpatr.vertices()[i+0];
    if (realpatr.vertices()[i+1] < miny)
      miny = realpatr.vertices()[i+1];
    if (realpatr.vertices()[i+1] > maxy)
      maxy = realpatr.vertices()[i+1];
    if (realpatr.vertices()[i+2] < minz)
      minz = realpatr.vertices()[i+2];
    if (realpatr.vertices()[i+2] > maxz)
      maxz = realpatr.vertices()[i+2];
  }
  //en veritat el diametre esta mal calculat, cada component s'hauria de multiplicar per l'escala dos cops
  //llavors hauriem de acumular el maxim
  //aquest seria en veritat el diametre del patricio sense escalar

   //std::cout << acos(1/2) << std::endl;
   //la  vaca esta girada originalment
  escalapatr = 0.25/(maxy-miny);
  //float a=radiesc(patr);
  //multiplico per
  float xorig= escala*(maxx-minx)/2,   zorig=escala*(maxz - minz)/2;//distancia de la x al origen
  //std::cout << "escalapatr" << escalapatr << std::endl;
  //float a = sqrt(((maxx-minx)*(maxx-minx)*escala*escala/4)+ 9 + ((maxz-minz)*(maxz-minz)*escala*escala)/4);
  float a = sqrt( 9 + xorig*xorig + zorig*zorig);

  if(a>radiEsc)
          radiEsc= a;//posa un valor adequat al radi de la escena
  centrerealPatr[0] = (minx+maxx)/2.0; centrerealPatr[1] = (miny+maxy)/2.0; centrerealPatr[2] = (minz+maxz)/2.0;
}

void MyGLWidget::keyPressEvent(QKeyEvent* event) 
{
  makeCurrent();
  switch (event->key()) {
    case Qt::Key_O: { // canvia òptica etntre perspectiva i axonomètrica
      perspectiva = !perspectiva;
      projectTransform ();
      break;
    }
    case Qt::Key_0:{
       valormodelllum=0;
       glUniform1i(modelllum,valormodelllum);
       break;

    }
     case Qt::Key_1:{
        valormodelllum=1;
        glUniform1i(modelllum,valormodelllum);
        break;
    }
      case Qt::Key_2:{
         valormodelllum=2;
         glUniform1i(modelllum,valormodelllum);
         break;
     }
  case Qt::Key_3:{
     valormodelllum=3;
     glUniform1i(modelllum,valormodelllum);
     break;
  }
   case Qt::Key_R:{
         rotacio=rotacio+float(M_PI)/6.f;
       glUniform1i(modelllum,valormodelllum);
      break;
  }
  case Qt::Key_X:{
      glUniform1i(mode,1);
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
  else if(e->button() & Qt::RightButton &&
          !(e->modifiers() & (Qt::ShiftModifier|Qt::AltModifier|Qt::ControlModifier))){
      DoingInteractive= ZOOM;
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
  else if(DoingInteractive == ZOOM){
      /**
    //std::cout << "tendria que hacer zoom" << std::endl;
    //cada posicio de y serà un grau
    float oldfov=FOV;
    FOV += (e->y() - yClick)*M_PI/180.0;
    if(FOV<M_PI/36.0f) FOV=M_PI/36.0f;
    if(FOV> M_PI/1.2)FOV=M_PI/1.2;//perque no sens vagi de mare
    //sino quan nem a angles mes peques de 0 o mes grans de 180
    //apocalipsis
    projectTransform();
    //calculo malament el varemo
    float varemo = M_PI/1.2 - M_PI/36.0f;
    //std::cout << "varemo" << varemo << std::endl;
    //std::cout << "proporcio" << (FOV- M_PI/36.0f) /varemo << std::endl;

    float proporcio=(FOV-M_PI/36.0f)/varemo ;

    valuechanged(proporcio*100);
    */

  }
  xClick = e->x();
  yClick = e->y();

  update ();
}
void MyGLWidget::changeFOV(int value){
    makeCurrent();

    //std::cout << value << std::endl;
    float proporcio = float(value)/100.0f;
    //std::cout <<"proporcio:"  << proporcio << std::endl;
    //std::cout << "antes" << FOV << std::endl;
    FOV=(M_PI/36.0f) +((M_PI/1.2f) - (M_PI/36.0f))*proporcio;
    //std::cout << "despues" << FOV << std::endl;


    projectTransform();

    update();
    //std::cout <<"deberia actualizarme pero no me da la gana"  << std::endl;
    return;

}



