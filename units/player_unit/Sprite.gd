extends Sprite


func _highlight():
	self_modulate = Color.aqua


func _disable_highlight():
	self_modulate = Color.white


func _on_mouse_entered():
	_highlight()


func _on_mouse_exited():
	_disable_highlight()
