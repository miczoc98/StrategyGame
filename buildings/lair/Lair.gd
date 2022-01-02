class_name Lair
extends Building

onready var _vision = $Vision
onready var _spawner = $Spawner

var map: Map

var _is_spawn_cooldown_on = false

func _ready():
	set_max_health(500)


func init():
	_vision.enemy_groups = GroupRelations.get_enemies(self)
	
	_spawner.map = map


func _on_vision_enemy_detected(enemy_position):
	if not _is_spawn_cooldown_on:
		_spawner.spawn(1, enemy_position)
		$Timer.start()
		_is_spawn_cooldown_on = true


func _on_timer_timeout():
	_is_spawn_cooldown_on = false
