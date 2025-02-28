//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 texel;
uniform vec3 color;

//Handle fragments/pixels.
void main()
{
    vec4 texCol = texture2D( gm_BaseTexture, v_vTexcoord );
    if (texCol.a == 1.0) {
        vec2 coord = v_vTexcoord;
    
        float alpha = 1.0 - texture2D(gm_BaseTexture, coord + vec2(texel.x, 0.0)).a;
        alpha += 1.0 - texture2D(gm_BaseTexture, coord + vec2(-texel.x, 0.0)).a;		
        alpha += 1.0 - texture2D(gm_BaseTexture, coord + vec2(0.0, texel.y)).a;
        alpha += 1.0 - texture2D(gm_BaseTexture, coord + vec2(0.0, -texel.y)).a;
        texCol.rgb = color.rgb;
        texCol.a = clamp(alpha, 0.0, 1.0);
    }
    
    gl_FragColor = v_vColour * texCol;
}
