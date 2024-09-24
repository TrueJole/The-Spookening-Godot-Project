shader_type spatial;
render_mode blend_add;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D NOISE_TEXTURE: repeat_enable;
uniform float strength: hint_range(0.0, 80, 0.1) = 1.0;
uniform float uv_scaling: hint_range (0.0, 1.0, 0.05) = 1.0;
uniform vec2 movement_direction = vec2(1, 0);
uniform float movement_speed: hint_range (0.0, 0.5, 0.01) = 0.1;
uniform float blue_filter: hint_range (0.0, 2, 0.01) = 1;
uniform vec4 color_addition: source_color;

void fragment() {
	vec2 uv = UV;
	vec2 movement_factor = movement_direction * movement_speed * TIME;
	float noise_value = texture(NOISE_TEXTURE, uv*uv_scaling + movement_factor).g - 0.5;
	uv += noise_value * strength;
	ALPHA = noise_value;
	//COLOR.b *= blue_filter;
	ALBEDO.rgb = texture(screen_texture, uv).rgb;
	ALBEDO.rgb += color_addition.rgb;

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
