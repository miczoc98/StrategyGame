shader_type canvas_item;

uniform bool is_active = false;

const float border_thickness = 0.03;

bool is_out_of_bounds(vec2 uv){
	return uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0; 
}

bool is_transparent(vec2 uv, sampler2D tex){
	return texture(tex, uv).a < 0.05;
}

bool test_uv(vec2 uv, sampler2D tex){
	return is_out_of_bounds(uv) || is_transparent(uv, tex);
}

bool is_edge(vec2 uv, sampler2D tex){
	vec2 directions[] = {
		vec2(border_thickness, 0.0),
		vec2(-border_thickness, 0.0),
		vec2(0.0, border_thickness),
		vec2(0.0, -border_thickness),
		vec2(border_thickness),
		vec2(-border_thickness),
		vec2(-border_thickness, border_thickness),
		vec2(border_thickness, -border_thickness)
	};
	
	for (int i = 0; i < directions.length(); i++){
		if (test_uv(uv + directions[i], tex) == true && test_uv(uv, tex) == false){
			return true;
		}
	}
	return false;
}

void fragment(){
	if (is_active && is_edge(UV, TEXTURE)){
		COLOR = vec4(.4, 0.4, 0.7, 1.0);
	} else {
		COLOR = texture(TEXTURE, UV)
	}
}