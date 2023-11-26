extends Node

func _on_player_entered(body):
	if body.has_method("respawn"):
		body.previous_checkpoint = $Marker2D.global_position
		body.lives_remaining = 3
