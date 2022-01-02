extends Camera2D

var map;
var movement_keys = {KEY_W: Vector2.UP, KEY_S: Vector2.DOWN, KEY_A: Vector2.LEFT, KEY_D: Vector2.RIGHT}
var camera_speed = 20;

var last_frame_screen_center: Vector2
var last_position: Vector2

func _ready():
	map = get_tree().get_nodes_in_group("map")[0]

	var bounding_box: Rect2  = map.get_bounding_box()
#	limit_bottom = (bounding_box.position.y + bounding_box.size.y) * 64
#	limit_top = (bounding_box.position.y) * 64
#	limit_left = (bounding_box.position.x) * 64
#	limit_right = (bounding_box.position.x + bounding_box.size.x) * 64
	

func _process(_delta):
	if has_not_moved_x():
		position.x = last_position.x
	if has_not_moved_y():
		position.y = last_position.y
	
	last_position = position
	last_frame_screen_center = get_camera_screen_center()
	
	for key in movement_keys.keys():
		if(Input.is_key_pressed(key)):
			position += movement_keys[key] * camera_speed

func has_not_moved_x():
	return not is_equal_approx(position.x, last_position.x) and \
		is_equal_approx(last_frame_screen_center.x, get_camera_screen_center().x)

func has_not_moved_y():
	return not is_equal_approx(position.y, last_position.y) and \
		is_equal_approx(last_frame_screen_center.y, get_camera_screen_center().y)
