class_name Statistics
extends Node2D

var generator := RandomNumberGenerator.new()

var unit_name: String = ""
var stats: Dictionary = {"mining": 0, "woodcutting": 0, "gathering": 0,
	 "building": 0, "figthing": 0}


func _init():
	generator.randomize()
	_init_stats()


func _init_stats():
	var name_list = _load_name_list()
	unit_name = _get_random_name(name_list)
	
	for key in stats.keys():
		stats[key] = int(clamp(generator.randfn(20, 15), 0, 100))


func _load_name_list():
	var name_list = []
	
	var file = File.new()
	file.open("res://names.csv", File.READ)
	
	while !file.eof_reached():
		name_list.append(file.get_line())
		
	return name_list


func _get_random_name(name_list: Array):
	return name_list[generator.randi_range(0, name_list.size() - 1)]
