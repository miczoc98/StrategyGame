extends Node


var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	
	for i in [1, 2, 3, 4]:
		noise.seed = randi()
		noise.octaves = 4
		noise.period = 64.0

		
		noise.get_seamless_image(64 * 16).save_png("res://tilemaps/fog/noise" + str(i) + ".png")
	
