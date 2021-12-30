extends State

var rand = RandomNumberGenerator.new()

onready var _fog_map: Fog = $"/root/Environment/Navigation/Fog"

var _exploration_radius = 64 * 10
var _central_point: Vector2
var _timeout := 10

func _init():
	rand.randomize()

func enter(msg := {}):
	_central_point = _get_owner_unit().owner_castle.position
	var _direction = rand.randf_range(0, 360)
	
	var offset_vector = Vector2.UP.rotated(_direction)
	var current_tile = ((_central_point + offset_vector)/64).round()
	while offset_vector.length() < _exploration_radius and not _fog_map.is_fogged(current_tile):
		offset_vector = offset_vector + offset_vector.normalized() * 60
		current_tile = ((_central_point + offset_vector)/64).round()
		
	_state_machine.change_to("Navigating", {"target": _central_point + offset_vector, "timeout": _timeout})

func _get_owner_unit() -> Unit2D:
	var owner_unit = owner
	while (not owner_unit is Unit2D):
		owner_unit = owner_unit.onwer;
	return owner_unit
