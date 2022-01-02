extends Node2D
class_name Damage

onready var detector: Area2D = $Detector

var _enemy_groups = []

func set_enemy_groups(enemy_groups: Array):
	_enemy_groups = enemy_groups


func deal_damage(damage: int):
	var bodies_in_range = detector.get_overlapping_bodies()
	var enemies = _filter_enemies(bodies_in_range)

	if not enemies.empty():
		Nodes.get_closest_node(enemies, global_position).take_damage(damage)

func get_enemies_in_range():
	 return _filter_enemies(detector.get_overlapping_bodies())


func _filter_enemies(bodies_in_range):
	var enemies = []
	for enemy_group in _enemy_groups:
		enemies.append_array(Nodes.filter_by_group(bodies_in_range, enemy_group))
	return enemies
