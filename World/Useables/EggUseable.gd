extends StaticBody2D

func _on_timer_timeout():
	queue_free()

func _on_interaction_area_body_entered(body):
	if body.has_method("seek_egg"):
		body.seek_egg(global_position)
