extends Building

func _ready():
	set_max_health(500)
	connect("destroyed", self, "_on_destroyed")
	
func _on_destroyed(orb):
	GlobalMediator.action("orb_destroyed", [self])


