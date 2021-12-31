#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(0.0,0.0,1.0,1.0);
    vtexCoord = texCoord;
    float angle = - time*texCoord.s;
    mat4 rotacio = mat4(vec4(cos(-angle),0,sin(-angle),0.),
			vec4(0,1,0,0.),
			vec4(-sin(-angle),0,cos(-angle),0.),
			vec4(0.,0.,0.,1.)
			);
    gl_Position = projectionMatrix * viewMatrix *  rotacio * vec4(vertex, 1.0);
}
