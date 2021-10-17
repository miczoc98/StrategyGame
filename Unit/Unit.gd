extends KinematicBody2D
class_name Unit2D

var _max_speed := 100.0
var behaviour: KinematicBehaviour = null
var nav: Navigation2D = null

var path_to_target: PoolVector2Array = PoolVector2Array()

var target: Node = null
var target_prefab = preload("res://Target.tscn")
var targets_in_path: Array = []

func _ready():
	$"/root/Environment".connect("target_spawned", self, "on_environment_target_spawned")
	nav = $"/root/Environment/Navigation2D"


func _physics_process(delta):
	if behaviour != null:
		var steering: SteeringOutput = behaviour._getSteering()
		move_and_slide(steering.linearVelocity)
		

	
func on_environment_target_spawned(target: Node2D):
	path_to_target = find_path(target)

	for node in path_to_target:

		spawn_node(node)

	behaviour = KinematicSeek.new()
	behaviour.init(self, self.position, _max_speed)

	behaviour.connect("target_reached", self, "on_target_reached")


func spawn_node(node: Vector2):
	target = target_prefab.instance()
	$"/root/Environment".add_child(target)
	target.position = node
	targets_in_path.append(target)

func find_path(target: Node2D) -> PoolVector2Array:
	clear_old_path()
		
	return nav.get_path_to_target(self.position, target.position)
	
func clear_old_path():
	for mark in targets_in_path:
		mark.queue_free()
	targets_in_path = []
	
func on_target_reached():
	if (path_to_target.size() > 0):
		behaviour._target = path_to_target[0]
		path_to_target.remove(0)

