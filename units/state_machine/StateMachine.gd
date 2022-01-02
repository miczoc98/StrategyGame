extends Node
class_name StateMachine

export(String) var starting_state: String = ""

var state:State = null
var history = []


func start() -> void:
	for state in get_children():
		state.init()
	
	state = get_node(starting_state)
	_enter_state()


func _enter_state(msg: Dictionary = {}) -> void:
	if state != null:
		state.enter(msg)


func _process(delta: float) -> void:
	if state != null:
		state.process(delta)


func _physics_process(delta: float) -> void:
	if state != null:
		state.physics_process(delta)


func _input(event: InputEvent) -> void:
	if state != null:
		state.input(event)


func _unhandled_input(event: InputEvent) -> void:
	if state != null:
		state.unhandled_input(event)


func change_to(new_state, msg: Dictionary = {}) -> void:
	state.exit()
	history.append(state.get_path())
	state = get_node(new_state)
	_enter_state(msg)
	
func back() -> void:
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()


