extends CharacterBody2D

signal target_detected
signal player_escaped_detection
signal arrived_at_path
signal game_over

signal clear_inventory

var chase_speed = 50
var return_speed = 40
var patrol_speed = 1
var previous_frame_position
var detection_position
var patroller
var patrolling
var player_target
var pathfinding

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
	elif pathfinding:
		move_towards(navigation_agent.get_next_path_position(), return_speed)
		move_detection_cone(velocity)
		if global_position.distance_to(navigation_agent.target_position) < 1:
			print("reached <1 pixel to the egg")
			pathfinding = false
			if patroller: patrolling = true
	elif patrolling:
		get_parent().progress += 1
		var direction = (previous_frame_position - global_position)
		direction = direction.normalized() * chase_speed
		animate_movement(direction)
		move_detection_cone(velocity)

func _process(_delta):
	for ray in detection_rays.get_children():
		if ray.is_colliding() and ray.get_collider().is_in_group("Player"):
			on_player_detection(ray.get_collider())

func move_towards(target_vector, speed):
	var direction = (target_vector - global_position)
	velocity = direction.normalized() * speed
	animate_movement(velocity)
	move_and_slide()

func animate_movement(velocity):
	if velocity.x > 33:
		$AnimationPlayer.play("running_right")
	elif velocity.x < -33:
		$AnimationPlayer.play("running_left")
	elif velocity.y > 0:
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
	player_target = player

func _on_detection_area_body_exited(body):
	if body.name == "Player" and player_target:
		if patroller: 
			navigation_agent.set_target_position(detection_position)
		else:
			navigation_agent.set_target_position(spawn_point)
		pathfinding = true
		player_target = null

func seek_egg(egg_position):
	print("egg has been detected")
	if !player_target:
		if patroller: 
      patrolling = false
      detection_position = global_position
		navigation_agent.set_target_position(egg_position)
		pathfinding = true

func _return_to_path(detection_position):
	if !player_target:
		navigation_agent.set_target_position(detection_position)
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