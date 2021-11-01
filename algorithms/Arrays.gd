class_name Arrays

static func min(array: Array):
	var minimum = array[0]
	for element in array:
		minimum = min(minimum, element)
		
	return minimum
