#version 330 core

in vec3 vertex;
in vec3 normal;

in vec3 matamb;
in vec3 matdiff;
in vec3 matspec;
in float matshin;



uniform mat4 proj;
uniform mat4 view;
uniform mat4 TG;


//afegit
out vec3 fvertex;
out vec3 fnormal;

out vec3 fmatamb;
out vec3 fmatdiff;
out vec3 fmatspec;
out float fmatshin;

uniform float mycolor;

//out vec3 fcolor;

void main()
{	
    fvertex = vec3(vertex);
    fnormal = vec3(normal);
    fmatdiff = vec3(matdiff);
    fmatspec = vec3(matspec);
    fmatamb = vec3(matamb);
    fmatshin = float(matshin);

    //fcolor = matdiff;
    gl_Position = proj * view * TG * vec4 (vertex, 1.0);
}
