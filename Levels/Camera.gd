extends Camera2D

var target_position

@export var original_position: Vector2
@export var second_position: Vector2

func _process(_delta):
	if target_position:
		var velocity = (target_position - position).normalized()
		if target_position.distance_to(position) > 4:
			position += velocity * 6

func _on_camera_movement_zone_body_entered(body):
	if body.is_in_group("Player"):
		target_position = second_position

func _on_camera_movement_zone_body_exited(body):
	if body.is_in_group("Player"):
		target_position = original_position
