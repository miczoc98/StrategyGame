extends Building

onready var vision = $Vision

var _is_spawn_cooldown_on = false

func _ready():
	set_max_health(500)

func _on_vision_enemy_detected():
	if not _is_spawn_cooldown_on:
		$Spawner.spawn(1, $Vision.get_enemies_in_range()[0].global_position)
		_is_spawn_cooldown_on = true
		$Timer.start()


func _on_timer_timeout():
	_is_spawn_cooldown_on = false
