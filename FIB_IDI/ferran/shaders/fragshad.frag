#version 330 core


in vec3 fvertex;
in vec3 fnormal;

in vec3 fmatamb;
in vec3 fmatdiff;
in vec3 fmatspec;
in float fmatshin;

uniform float esvaca;
uniform float franja;

uniform mat4 proj;
uniform mat4 view;
uniform mat4 TG;

uniform vec3 colFocus;
uniform vec3 posFocus;

out vec4 FragColor;



vec4 black = vec4(0.0, 0.0, 0.0, 0.0);
vec4 white = vec4(1.0, 1.0, 1.0, 1.0);


vec3 llumAmbient = vec3(0.2, 0.2, 0.2);


vec3 Lambert (vec3 NormSCO, vec3 L) 
{
    // S'assumeix que els vectors que es reben com a paràmetres estan normalitzats

    // Inicialitzem color a component ambient
    vec3 colRes = llumAmbient * fmatamb;

    // Afegim component difusa, si n'hi ha
    if (dot (L, NormSCO) > 0)
      colRes = colRes + colFocus * fmatdiff * dot (L, NormSCO);
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

    if ((dot(R, V) < 0) || (fmatshin == 0))
      return colRes;  // no hi ha component especular
    
    // Afegim la component especular
    float shine = pow(max(0.0, dot(R, V)), fmatshin);
    return (colRes + fmatspec * colFocus * shine); 
}


void main()
{	
	if(franja == 0) {
		mat3 nMatrix = inverse(transpose(mat3(view * TG)));
		vec3 NormSCO = normalize(nMatrix * fnormal);
		vec4 vertexSCO = view * TG * vec4(fvertex, 1.0);
		vec4 pFocusSCO = view * vec4(posFocus, 1.0);
		vec4 L = pFocusSCO - vertexSCO;
		vec3 Lxyz = normalize(L.xyz);
		vec3 fcolor = Phong(NormSCO, Lxyz, vertexSCO);
		
		FragColor = vec4(fcolor,1);	
	}
	else {
		if (gl_FragCoord.y < 400. && gl_FragCoord.y > 300.) FragColor = black;
		else if (gl_FragCoord.y < 300. && gl_FragCoord.y > 200.) FragColor = white;
		else if (gl_FragCoord.x < 200. && gl_FragCoord.y > 100.) FragColor = black;
		else FragColor = white;
	}
	
	
	
}
