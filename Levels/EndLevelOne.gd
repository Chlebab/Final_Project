extends StaticBody2D

func _process(_delta):
	pass


func _on_end_level_area_body_entered(body):
	if body.get_name() == "Player":
		get_parent().get_node("Transition").play("fade_odut")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Levels/LevelTwo.tscn")
