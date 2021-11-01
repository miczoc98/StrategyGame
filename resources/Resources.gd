class_name Resources

static func get_resource(name: String):
	var resources_by_name = {"wood": Wood, "stone": Stone, "food": Food}
	return resources_by_name[name].new()
	

class Wood extends Gatherable:
	func _init():
		type = "wood"
		skill_required = "woodcutting"
		map = "Trees"
		layer = 3

class Stone extends Gatherable:
	func _init():
		type = "stone"
		skill_required = "mining"
		map = "Mountains"
		layer = 5
class Food extends Gatherable:
	func _init():
		type = "food"
		skill_required = "gathering"
		map = "Berries"
		layer = 6
