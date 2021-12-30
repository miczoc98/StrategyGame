class_name PlayerGUI
extends CanvasLayer

var mediator: Mediator


func _wait_for_player_ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
