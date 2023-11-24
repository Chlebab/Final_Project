extends Node2D

signal open_door

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player" and Input.is_action_just_pressed("h"):
			open_door.emit()
			print("player next to button")
