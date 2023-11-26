extends Node2D

signal open_door
var open = false
var player_in_area = false

func _process(delta):
	if Input.is_action_just_pressed("open_door"):
		press_button()


func _on_area_2d_body_entered(body):
	if body.get_name() == "Player": 
		player_in_area = true
		print("player in button")
		
func _on_area_2d_body_exited(body):
	player_in_area = false
	print("player left button")
		
func press_button():
	if player_in_area: 	
		open_door.emit()
		
		
		print("player pressed button")	
		

