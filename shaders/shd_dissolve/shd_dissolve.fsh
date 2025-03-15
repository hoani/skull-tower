//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float frac;
uniform float time;

float hash(vec2 p)
{
    p = mod(p, 7.31); //Bring 'p' to a useful range.
    //Generate a pseudo random number from 'p'.
    return fract(sin(p.x*12.9898 + p.y*78.233) * 43758.5453);
}

//Handle fragments/pixels.
void main()
{
    //Set the output the vertex color multiplied by texture color of each pixel.
    vec4 texCol = texture2D( gm_BaseTexture, v_vTexcoord );
    texCol.a *= (hash(v_vTexcoord*(time + 1.0))) < frac ? 0.:1.;  
    
    gl_FragColor = v_vColour * texCol;
}
