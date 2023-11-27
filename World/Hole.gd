extends Node2D

func _on_someone_falls_in(body):
	print("r")
	if body.has_method("fall_into_hole"):
		await get_tree().create_timer(0.05).timeout
		body.fall_into_hole()
