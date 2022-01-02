class_name Vision
extends Node2D

signal enemy_detected(position)

onready var _layer = $Area2D.collision_layer

var enemy_groups := []


func disable():
	$Area2D.collision_layer = 0


func enable():
	$Area2D.collision_layer = _layer


func _enemy_detected(body: Node) -> Dictionary:
	for enemy_group in enemy_groups:
		if body.is_in_group(enemy_group):
			return {"detected": true, "group": enemy_group}
	return {"detected": false, "group": ""}


func get_enemies_in_range():
	var bodies = get_bodies_in_range()
	return Nodes.filter_by_any_group(bodies, enemy_groups)
	
func get_bodies_in_range():
	var overlapping_bodies =  $Area2D.get_overlapping_bodies()
	var bodies_in_range = []
	for body in overlapping_bodies:
		if body.global_position.distance_to(global_position) < $Area2D/CollisionShape2D.shape.radius:
			bodies_in_range.append(body)
	
	return bodies_in_range
	
func _on_timer_timeout():
	for body in get_bodies_in_range():
		var detection_result = _enemy_detected(body)
		if (detection_result.detected):
			emit_signal("enemy_detected", body.global_position)
