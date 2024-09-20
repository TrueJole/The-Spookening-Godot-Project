shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D NOISE_TEXTURE: repeat_enable;
uniform float strength: hint_range(0.0, 40, 0.1) = 1.0;
uniform float uv_scaling: hint_range (0.0, 1.0, 0.05) = 1.0;
uniform vec2 movement_direction = vec2(1, 0);
uniform float movement_speed: hint_range (0.0, 0.5, 0.01) = 0.1;
uniform float blue_filter: hint_range (0.0, 2, 0.01) = 1;
uniform vec4 color_addition: source_color;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 movement_factor = movement_direction * movement_speed * TIME;
	float noise_value = texture(NOISE_TEXTURE, uv*uv_scaling + movement_factor).r - 0.5;
	uv += noise_value * SCREEN_PIXEL_SIZE * strength;
	COLOR = texture(screen_texture, uv);
	COLOR.b *= blue_filter;
	COLOR.rgb *= color_addition.rgb;
	//COLOR.rgb *= 5.0;
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
