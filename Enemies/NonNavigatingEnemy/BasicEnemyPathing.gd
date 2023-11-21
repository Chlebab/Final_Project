extends Path2D

@onready var patroller = $PathFollow2D/BasicEnemy

signal return_to_path

var progress = 0
var patrol_speed = 40

var patrolling = true
var detection_position = null
var returning_to_path = false


func _process(delta):
	if patrolling:
		$PathFollow2D.progress += delta * patrol_speed

func _on_return_to_path():
	patrolling = true

func _on_player_detected():
	if patrolling:
		patrolling = false
		detection_position = patroller.global_position
	elif returning_to_path:
		returning_to_path = false

func _on_player_escaped_detection():
	return_to_path.emit(detection_position)
