extends Node2D

var end_screen = preload("res://player/GUI/end_screen/EndScreen.tscn")

func _ready():
	GlobalMediator.subscribe("game_won", funcref(self, "_on_game_won"))
	
func _on_game_won():
	add_child(end_screen.instance())
	
