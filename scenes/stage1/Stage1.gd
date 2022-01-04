extends Node2D


func _ready():
	yield(get_tree(), "idle_frame")
	
	$Map.init()
	
	$Player.map = $Map
	$Player.init()
	
	$Neutral.map = $Map
	$Neutral.init()

	GlobalMediator.action("map_loaded")
