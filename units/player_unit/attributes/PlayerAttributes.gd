extends Attributes

var generator := RandomNumberGenerator.new()

func _init():
	generator.randomize()
	stats = {"mining": 0, "woodcutting": 0, "gathering": 0, "fighting": 0}
	
	_init_stats()

func _init_stats():
	var name_list = _load_name_list()
	unit_name = _get_random_name(name_list)
	
	for key in stats.keys():
		stats[key] = int(clamp(generator.randfn(20, 15), 0, 100))


func _load_name_list():
	var name_list = []
	
	var file = File.new()
	file.open("res://names.txt", File.READ)
	
	while !file.eof_reached():
		name_list.append(file.get_line())
		
	return name_list


func _get_random_name(name_list: Array):
	return name_list[generator.randi_range(0, name_list.size() - 1)]


func _on_regen_timer_timeout():
	take_damage(-10)
