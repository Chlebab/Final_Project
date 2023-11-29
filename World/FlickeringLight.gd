extends PointLight2D

var random = RandomNumberGenerator.new()

func _ready():
	get_parent().play()
	random.randomize()
	while 1 == 1:
		await get_tree().create_timer(randf_range(0.06, 0.14)).timeout
		energy = randf_range(0.66, 0.85)
		texture_scale = randf_range(13.0,14.7)
