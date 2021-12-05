class_name Vision
extends Node2D

var _enemy_groups := []

func _ready():
	_enemy_groups = GroupRelations.get_enemies(owner)
	
func _on_Area2D_body_entered(body):
	if (_enemy_detected(body)):
		print("detected enemy, entering combat")
		owner.get_node("StateMachine").change_to("Combat")


func _enemy_detected(body: Node):
	for enemy_group in _enemy_groups:
		if body.is_in_group(enemy_group):
			print("detected enemy: " + str(body))
			return true
	return false


func get_bodies_in_range():
	return $Area2D.get_overlapping_bodies()
