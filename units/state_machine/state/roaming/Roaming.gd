extends State

var rand = RandomNumberGenerator.new()

var _roam_radius = 64 * 4


func enter(_msg := {}):
	var _direction = rand.randf_range(0, 360)
	var _distance = rand.randf_range(0, _roam_radius)
	
	var target_vector = Vector2.UP.rotated(_direction).normalized() * _distance
	
	_get_state_machine(self).change_to("Navigating", {"target": owner.global_position + target_vector})
