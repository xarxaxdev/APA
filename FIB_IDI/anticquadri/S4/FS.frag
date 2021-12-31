#version 330 core

//in
in vec3 fcolor;

//out
out vec4 pepito;
//out vec4 color:


void main(){
   // color=vec4(fcolor,1.0);
    if((int(gl_FragCoord.y)%50)>30) discard;
    pepito= vec4(1.);
    if(gl_FragCoord.x< 300.)pepito=vec4(0.,0.5,0.5,1);
}
