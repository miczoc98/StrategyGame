class_name Jobs

static func get_job(job_name: String) -> Job:
	var jobs_by_name = {
		"woodcutting": WoodcuttingJob,
		"mining": MiningJob,
		"food": FoodJob,
		"exploration": Exploring
	 }
	return jobs_by_name[job_name].new()
	
static func get_jobs() -> Array:
	return [WoodcuttingJob.new(), MiningJob.new(), FoodJob.new(), Exploring.new()]
	
class WoodcuttingJob extends GatheringJob:
	func _init():
		name = "woodcutting"
		associated_skill = "woodcutting"
		resource = "wood"
		
class MiningJob extends GatheringJob:
	func _init():
		name = "mining"
		associated_skill = "mining"
		resource = "stone"
		
class FoodJob extends GatheringJob:
	func _init():
		name = "food"
		associated_skill = "gathering"
		resource = "food"

class Exploring extends ExplorationJob:
	func _init():
		name = "exploration"
		associated_skill = "none"
