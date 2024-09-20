shader_type spatial;
render_mode unshaded;

uniform sampler2D reflection_texture;
void fragment() {
	ALBEDO = texture(reflection_texture, vec2(1.0 - SCREEN_UV.x, SCREEN_UV.y)).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
