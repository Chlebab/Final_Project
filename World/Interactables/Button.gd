extends Node2D

signal open_door

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		open_door.emit()
		print("player next to button")
