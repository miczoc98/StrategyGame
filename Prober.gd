extends Area2D

var detector: CollisionShape2D = null

var colliders: Array = []

func _ready():
	connect("body_entered", self, )

func set_radius(radius: float) -> void:
	if detector != null:
		remove_child(detector)
	
	var detector = CircleShape2D.new()
	detector.radius = radius
	add_child(detector)
	
func _on_body_entered(body: Node):
	colliders.add
	
