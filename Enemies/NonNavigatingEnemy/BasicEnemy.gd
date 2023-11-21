extends CharacterBody2D

@export var speed = 60
var target = null
var path_return_point = null

signal player_detected
signal player_escaped_detection
signal arrived_at_path

func _ready():
	$Sprite2D/AnimationPlayer.play("idle")

func _physics_process(_delta):
	if target:
		move_towards(target.global_position)
	if path_return_point:
		move_towards(path_return_point)
		if global_position.distance_to(path_return_point) < 1:
			arrived_at_path.emit()
			path_return_point = null
			$Sprite2D/AnimationPlayer.play("idle")

func move_towards(target_vector):
	var direction = (target_vector - global_position)
	velocity = direction.normalized() * speed
	move_and_slide()
	$Sprite2D/AnimationPlayer.play("chasing")

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player_detected.emit()
		target = body

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_escaped_detection.emit()
		target = null

func _return_to_path(detection_position):
	path_return_point = detection_position
