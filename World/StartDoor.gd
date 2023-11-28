extends StaticBody2D

func _ready():
	await get_tree().create_timer(7).timeout
	$Open.hide()
	$Close.show()
	$Close.play()


	

		


