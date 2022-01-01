class_name Vision
extends Node2D

signal enemy_detected()

var _enemy_groups := []
onready var _layer = $Area2D.collision_layer

func _ready():
	_enemy_groups = GroupRelations.get_enemies(owner)


func disable():
	$Area2D.collision_layer = 0
	

func enable():
	$Area2D.collision_layer = _layer

func _enemy_detected(body: Node) -> Dictionary:
	for enemy_group in _enemy_groups:
		if body.is_in_group(enemy_group):
			return {"detected": true, "group": enemy_group}
	return {"detected": false, "group": ""}


func get_enemies_in_range():
	var bodies = get_bodies_in_range()
	return Nodes.filter_by_any_group(bodies, _enemy_groups)
	
func get_bodies_in_range():
	return $Area2D.get_overlapping_bodies()


func _on_timer_timeout():
	for body in get_bodies_in_range():
		var detection_result = _enemy_detected(body)
		if (detection_result.detected):
			emit_signal("enemy_detected")
			GlobalMediator.action("enemy_detected", [detection_result.group, body.global_position])
