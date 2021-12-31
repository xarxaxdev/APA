#version 330 core


in vec3 vertex;
in vec3 normal;

in vec3 matamb;
in vec3 matdiff;
in vec3 matspec;
in float matshin;

//variables afegides per temes de llum
uniform int modelllum;//escull el model de iluminacio
uniform int mode;

flat out int fmode;


//aquests venien ja i son basic
uniform mat4 proj;
uniform mat4 view;
uniform mat4 TG;

// Valors per als components que necessitem dels focus de llum
//cyan -> verd i blau
//magenta -> vermell i blau
//groc -> verd i vermell
// els colors estan en R G B
vec3 colFocus = vec3(0.2, 0.8, 0.8);
vec3 llumAmbient = vec3(0.2, 0.2, 0.2);
vec3 posFocus = vec3(1.f, 1.f, 1.f);  // en SCA


out vec3 fcolor;



vec3 Lambert (vec3 NormSCO, vec3 L) 
{
    // S'assumeix que els vectors que es reben com a paràmetres estan normalitzats

    // Inicialitzem color a component ambient
    vec3 colRes = llumAmbient * matamb;

    // Afegim component difusa, si n'hi ha
    if (dot (L, NormSCO) > 0)
      colRes = colRes + colFocus * matdiff * dot (L, NormSCO);
    return (colRes);
}

vec3 Phong (vec3 NormSCO, vec3 L, vec4 vertSCO) 
{
    // Els vectors estan normalitzats

    // Inicialitzem color a Lambert
    vec3 colRes = Lambert (NormSCO, L);

    // Calculem R i V
    if (dot(NormSCO,L) < 0)
      return colRes;  // no hi ha component especular

    vec3 R = reflect(-L, NormSCO); // equival a: normalize (2.0*dot(NormSCO,L)*NormSCO - L);
    vec3 V = normalize(-vertSCO.xyz);

    if ((dot(R, V) < 0) || (matshin == 0))
      return colRes;  // no hi ha component especular
    
    // Afegim la component especular
    float shine = pow(max(0.0, dot(R, V)), matshin);
    return (colRes + matspec * colFocus * shine); 
}

void main()
{	
    //   SCA             SCO
    //   vertex v        view*TG*v
    //   normal n        inverse(transpose(mat3(view*TG)))*n
    //  posFocus         view*posFocus
    //  direccio llum L  (posfocus - v) els dos en SCO
    fmode=mode;
    if(modelllum==1){
        //lambert
        mat3 NormalMatrix=inverse(transpose(mat3(view*TG)));
        vec3 normSCO= (NormalMatrix*normal);
        vec4 focusSCO= (view*vec4(posFocus,1.0));
        vec4 vertexSCO= (view* TG * vec4(vertex,1.0));
        vec4 L=focusSCO - vertexSCO;
        fcolor= Lambert(normalize(normSCO),normalize(L.xyz));
    }
    else if(modelllum==2){
        //phong
        vec3 observador=vec3(-1.0f,1.0f,-1.0f);
        mat3 NormalMatrix=inverse(transpose(mat3(view*TG)));
        vec3 normSCO= (NormalMatrix*normal);
        vec4 focusSCO= vec4(0,0,0,0);//si el foco es sempre a la posicio de la camera
        //llavors es a la 0,0,0 en SCO
        //vec4 focusSCO= (view*vec4(posFocus,1.0));//si tenim la posicio del focus en SCO
        vec4 vertexSCO= (view* TG * vec4(vertex,1.0));
        vec4 L=focusSCO - vertexSCO;
        fcolor= Phong(normalize(normSCO),normalize(L.xyz),vertexSCO);
    }
    else  fcolor = matdiff;
    gl_Position = proj * view * TG * vec4 (vertex, 1.0);
}
