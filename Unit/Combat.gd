extends Node2D

onready var detector:Area2D = $Detector
onready var timer:Timer = $Timer
onready var stats:Statistics = $"../Statistics"

var enemy_group = ""

func _ready():
	if get_parent().is_in_group("player_unit"):
		enemy_group = "enemy_unit"
	elif get_parent().is_in_group("enemy_unit"):
		enemy_group = "player_unit"


func _process(delta):
	if not detector.get_overlapping_bodies().empty():
		if (timer.is_stopped()):
			timer.start()
	else:
		timer.stop()

func _deal_damage():
	var bodies_in_range = detector.get_overlapping_bodies()
	var enemies = Nodes.filter_by_group(bodies_in_range, enemy_group)
	
	if not enemies.empty():
		Nodes.get_closest_node(enemies, global_position).take_damage(_calculate_damage())

func _calculate_damage():
	return 10 * stats.stats["fighting"] * 0.1

func _on_Timer_timeout():
	_deal_damage()
