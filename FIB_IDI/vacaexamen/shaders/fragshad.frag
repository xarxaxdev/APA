#version 330 core

in vec3 fcolor;
flat in int fmode;
out vec4 FragColor;

void main()
{
    if(fmode==0) FragColor=vec4(fcolor,1.0);
    else{
        if((int(gl_FragCoord.y) % 20 )< 10  ){
            FragColor = vec4(0.f,0.f,0.f,0.f);}
        else{
            FragColor = vec4(1.f,1.f,1.f,1.f);
        }
    }
}
