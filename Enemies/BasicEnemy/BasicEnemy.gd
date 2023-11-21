extends CharacterBody2D

signal player_detected
signal player_escaped_detection
signal arrived_at_path
signal game_over

signal clear_inventory

var chase_speed = 100
var return_speed = 40
var player_target
var pathfinding

@export var spawn_point = Vector2(0,0)
@onready var detection_rays = $DetectionZones/DetectionRays
@onready var navigation_agent = $NavigationAgent2D

func _physics_process(_delta):
	if player_target:
		move_towards(player_target.global_position, chase_speed)
	elif pathfinding:
		move_towards(navigation_agent.get_next_path_position(), return_speed)
		move_detection_cone(-velocity)
		if global_position.distance_to(navigation_agent.target_position) < 1:
			pathfinding = false
			arrived_at_path.emit()

func _process(_delta):
	for ray in detection_rays.get_children():
		if ray.is_colliding() and ray.get_collider().is_in_group("Player"):
			on_player_detection(ray.get_collider())

func move_towards(target_vector, speed):
	var direction = (target_vector - global_position)
	velocity = direction.normalized() * speed
	animate_movement()
	move_and_slide()

func animate_movement():
	if velocity.x > 33:
		$AnimationPlayer.play("running_right")
	elif velocity.x < -33:
		$AnimationPlayer.play("running_left")
	elif velocity.y > 0:
		$AnimationPlayer.play("running_down")
	else:
		$AnimationPlayer.play("running_up")

func move_detection_cone(input_velocity):
	detection_rays.rotation = -atan2(input_velocity.x, input_velocity.y)

func on_player_detection(player):
	player_detected.emit()
	player_target = player

func _on_detection_area_body_exited(body):
	if body.name == "Player" and player_target:
		player_escaped_detection.emit()
		player_target = null

func _return_to_path(detection_position):
	navigation_agent.set_target_position(detection_position)
	pathfinding = true

func _on_player_caught(body):
	if body.name == "Player":
		body.position = body.spawn_point
		global_position = get_parent().global_position
		arrived_at_path.emit()
		clear_inventory.emit()
		player_target = null