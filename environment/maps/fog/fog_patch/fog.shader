shader_type canvas_item;

const int noise_texture_size = 1028;
const int patch_size = 64;
const vec3 fog_color = vec3(0.70,0.80,1.00);

uniform vec2 tile_coordinates = vec2(0, 0);

uniform sampler2D noise;
uniform sampler2D noise2;
uniform sampler2D noise3;
uniform sampler2D noise4;

float cyclic_input(float input){
	if (int(input) % 2 == 0){
		return fract(input);
	}else {
		return 1.0 - fract(input);
	}
}

float texture_strength(float input, float order){
	return clamp((1.0 - 1.0 * cyclic_input(input + order/2.0)) * 0.5, 0, 1);
}

vec2 loop_offset(vec2 input, vec2 offset){
	vec2 output = input + offset;
	if (output.x > 1.0){
		output.x -= floor(output.x);
	}
	if (output.y > 1.0){
		output.y -= floor(output.y);
	}
	if (output.x < 0.0){
		output.x += floor(output.x);
	}
	if (output.y < 0.0){
		output.y += floor(output.y);
	}
	return output;
}

void fragment(){
	COLOR = vec4(fog_color, 1.0);

	int tiles_per_texture = noise_texture_size/patch_size;
	float distance_between_tiles = 1.0/float(tiles_per_texture);
	vec2 tile_begin = vec2(ivec2(tile_coordinates) % tiles_per_texture) * distance_between_tiles;
	
	vec2 uv = tile_begin + UV * distance_between_tiles;
	
	vec2 offset_uv = loop_offset(uv, vec2(TIME * 0.05, TIME * 0.05));
		
	float a1 = texture(noise, offset_uv).r;
	float a2 = texture(noise2, offset_uv).r;
	float a3 = texture(noise3, offset_uv).r;
	float a4 = texture(noise4, offset_uv).r;

	float time = TIME * 0.4;

	float a = a1 * texture_strength(time, 1) 
	+ a2 * texture_strength(time, 2) 
	+ a3 * texture_strength(time, 3) 
	+ a4 * texture_strength(time, 4);
	
	COLOR.a = a;
}

