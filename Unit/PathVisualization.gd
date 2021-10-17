extends Node2D

export var show_navigation = true

var node_marker_prefab = preload("res://Target.tscn")
var targets_in_path: Array = []

func _ready():
	$"..".connect("new_path_generated", self, "on_new_path_generated")

func on_new_path_generated(path: Array):
	clear_old_path()
	
	if (show_navigation):
		draw_path(path)

func draw_path(path: Array):
	for node in path:
		spawn_node(node)

func spawn_node(node: Vector2):
	var target = node_marker_prefab.instance()
	$"/root".add_child(target)
	target.position = node
	targets_in_path.append(target)
	
func clear_old_path():
	for mark in targets_in_path:
		mark.queue_free()
	targets_in_path = []
