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

func _on_Area2D_body_entered(body):
	if (_enemy_detected(body)):
		emit_signal("enemy_detected")


func _enemy_detected(body: Node):
	for enemy_group in _enemy_groups:
		if body.is_in_group(enemy_group):
			return true
	return false


func get_bodies_in_range():
	return $Area2D.get_overlapping_bodies()
