extends Node2D

var map: Map

func init():
	_init_buildings()


func _init_buildings():
	var neutral_buildings = get_tree().get_nodes_in_group("neutral")
	neutral_buildings = Nodes.filter_by_group(neutral_buildings, "building")
	
	for building in neutral_buildings:
		if building is Lair:
			building.map = map
		
		building.init()
