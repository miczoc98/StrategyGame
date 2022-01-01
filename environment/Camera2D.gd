extends Camera2D


var movement_keys = {KEY_W: Vector2.UP, KEY_S: Vector2.DOWN, KEY_A: Vector2.LEFT, KEY_D: Vector2.RIGHT}
var camera_speed = 5;

func _process(_delta):
	for key in movement_keys.keys():
		if(Input.is_key_pressed(key)):
			position += movement_keys[key] * camera_speed
