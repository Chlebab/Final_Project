extends PointLight2D

var random = RandomNumberGenerator.new()

func _ready():
	if get_parent().has_method("play"):
		get_parent().play()
	random.randomize()
	while 1 == 1:
		await get_tree().create_timer(randf_range(0.06, 0.12)).timeout
		energy = randf_range(0.76, 0.85)
		texture_scale = randf_range(13.8,14.7)
