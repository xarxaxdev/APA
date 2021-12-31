#version 330 core

//in
in vec3 fcolor;

//out
out vec4 pepito;
out vec4 color2;


void main(){
    color2=vec4(fcolor,1.0);
}
