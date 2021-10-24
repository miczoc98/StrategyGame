class_name MaskCalculator


static func sum(layers: Array):
	var sum = 0b0
	for layer in layers:
		var layer_bit = 0b1 << (layer - 1)
		sum = sum | layer_bit
	return sum
		
