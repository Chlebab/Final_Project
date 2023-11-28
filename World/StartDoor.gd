extends StaticBody2D



func _ready():
	await get_tree().create_timer(8).timeout
	$Open.hide()
	$Close.show()
	$Close.play()
	#self.collision_layer = 1
	#self.collision_mask = 1
