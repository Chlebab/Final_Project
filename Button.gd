extends Node2D

var door_instance = preload("res://World/door.tscn").instantiate()

signal open_door

func _ready():
	pass
	
	

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		open_door.emit()
		print("player next to button")



	
		
