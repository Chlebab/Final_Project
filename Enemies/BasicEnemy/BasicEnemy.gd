extends CharacterBody2D

signal game_over
signal clear_inventory

var chase_speed = 50
var return_speed = 40
var patrol_speed = 40
var previous_frame_position
var detection_position
var patroller
var patrolling
var player_target
var pathfinding
var eggseeking

@onready var spawn_point = global_position
@onready var detection_rays = $DetectionZones/DetectionRays
@onready var navigation_agent = $NavigationAgent2D

func _ready():
	if get_parent() is PathFollow2D:
		patroller = true
		patrolling = true
		previous_frame_position = global_position

func _physics_process(delta):
	if player_target:
		move_towards(player_target.global_position, chase_speed)
	if pathfinding:
		move_towards(navigation_agent.get_next_path_position(), return_speed)
		if global_position.distance_to(navigation_agent.target_position) < 1:
			pathfinding = false
			if patroller: patrolling = true
	if eggseeking:
		move_towards(navigation_agent.get_next_path_position(), chase_speed)
		if global_position.distance_to(navigation_agent.target_position) < 30:
			eggseeking = false
			await get_tree().create_timer(10.0).timeout
			# include idle animation here at some point
			return_to_path()
	if patrolling:
		get_parent().progress += delta * patrol_speed
		var direction = (global_position - previous_frame_position)
		direction = direction.normalized()
		animate_movement(direction)
		move_detection_cone(-direction)
		previous_frame_position = global_position

func _process(_delta):
	if !player_target:
		for ray in detection_rays.get_children():
			if ray.is_colliding() and ray.get_collider().is_in_group("Player"):
				on_player_detection(ray.get_collider())
				$AudioStreamPlayer2D.play()
				$DetectionLabel.visible = true
				await get_tree().create_timer(0.7).timeout
				$DetectionLabel.visible = false

func move_towards(target_vector, speed):
	var direction = (target_vector - global_position).normalized()
	animate_movement(direction)
	velocity = direction * speed
	move_detection_cone(-velocity)
	move_and_slide()

func animate_movement(direction):
	if direction.x > 0.7:
		$AnimationPlayer.play("running_right")
	elif direction.x < -0.7:
		$AnimationPlayer.play("running_left")
	elif direction.y > 0:
		$AnimationPlayer.play("running_down")
	else:
		$AnimationPlayer.play("running_up")

func move_detection_cone(input_velocity):
	detection_rays.rotation = atan2(-input_velocity.x, input_velocity.y)

func on_player_detection(player):
	if patrolling:
		patrolling = false
		detection_position = global_position
	elif pathfinding:
		pathfinding = false
	eggseeking = false
	player_target = player

func on_egg_detection(egg_position):
	if !player_target:
		if patroller: 
			patrolling = false
			detection_position = global_position
		navigation_agent.set_target_position(egg_position)
		eggseeking = true

func _on_detection_area_body_exited(body):
	if body.name == "Player" and player_target:
		return_to_path()
		player_target = null

func return_to_path():
	if patroller: 
		navigation_agent.set_target_position(detection_position)
	else:
		navigation_agent.set_target_position(spawn_point)
	pathfinding = true

func _on_player_caught(body):
	if body.name == "Player":
		body.position = body.spawn_point
		player_target = null
		if patroller:
			spawn_point = get_parent().global_position
			patrolling = true
		global_position = spawn_point
		clear_inventory.emit()
