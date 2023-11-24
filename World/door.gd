extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_door_area_body_entered(body):
	if body.get_name() == "Player":
		print("Player entered")
		$Close.hide()
		$Open.show()
		$Open.play
	


func _on_door_area_body_exited(body):
	if body.get_name() == "Player":
		print("Player exited")
		$Open.hide()
		$Close.show()
		$Close.play
	
