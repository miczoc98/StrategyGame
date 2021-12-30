shader_type canvas_item;

uniform vec2 region_size;
uniform vec2 region_position;
uniform float offset_scale = 0;

vec2 loop_texture(vec2 input){
	vec2 region_end = vec2(region_size + region_position);
	
	vec2 output = input;
	if (output.x > region_end.x){
		output.x -= region_size.x;
	}
	if (output.y > region_end.y){
		output.y -= region_size.y;
	}
	if (output.x < region_position.x){
		output.x += region_size.x;
	}
	if (output.y < region_position.y){
		output.y += region_size.y;
	}
	return output;
}


void fragment() {
	vec2 wave_offset = vec2(0.0);
	wave_offset.x = cos(TIME + UV.x * 6.3) * offset_scale;
	wave_offset.y = sin(TIME + UV.y * 6.3) * offset_scale;
	
	vec2 offset_uv = loop_texture(UV + wave_offset);

	COLOR = texture(TEXTURE, offset_uv);
}