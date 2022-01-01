extends State

func process(_delta: float):
	if (Input.is_key_pressed(KEY_1)):
		_state_machine.change_to("Gathering", {"resource": Resources.get_resource("wood")})
		print("gathering wood")
	if (Input.is_key_pressed(KEY_2)):
		_state_machine.change_to("Gathering", {"resource": Resources.get_resource("stone")})
		print("gathering stone")
	if (Input.is_key_pressed(KEY_3)):
		_state_machine.change_to("Gathering", {"resource": Resources.get_resource("food")})
		print("gathering food")
