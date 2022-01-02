extends PlayerController


func init():
	GlobalMediator.subscribe("unit_selected", funcref(self, "_on_unit_selected"))
	

func _on_unit_selected(unit: Unit2D):
	mediator.action("unit_selected", [unit])
