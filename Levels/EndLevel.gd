extends StaticBody2D

func _process(_delta):
	pass


func _on_end_level_area_body_entered(body):
	if body.get_name() == "Player":
		get_node()$Transition.play("")
		print("shoobydooby")
		#get_tree().change_scene_to_file("res://Levels/LiquidationDash.tscn")
