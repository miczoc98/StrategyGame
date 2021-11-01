class_name MaskCalculator


static func sum(layers: Array):
	var sum = 0b0
	for layer in layers:
		var layer_bit = 0b1 << (layer - 1)
		sum = sum | layer_bit
	return sum
	
static func get_layer_by_name(name: String) -> int:
	var layers_by_name = {}
	for i in range(10):
		var layer_name: String = ProjectSettings.get_setting("layer_names/2d_physics/layer_" + str(i + 1))
		if not layer_name.empty():
			layers_by_name[layer_name] = pow(2, i)
	
	return layers_by_name[name]
		
