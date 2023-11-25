extends CharacterBody2D

signal game_over
signal clear_inventory

var chase_speed = 50
var return_speed = 40
var patrol_speed = 40
var health = 60
var animating_action = false

var previous_frame_position # these two variables are to record the direction of 
var detection_position # movement while patrolling in order to adjust the enemy's vision

var patroller
var patrolling

var target
var pathfinding
var eggseeking

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.UP

@onready var spawn_point = global_position
@onready var detection_rays = $DetectionZones/DetectionRays
@onready var navigation_agent = $NavigationAgent2D

func _ready():
	if get_parent() is PathFollow2D:
		patroller = true
		patrolling = true
		previous_frame_position = global_position

func _physics_process(delta):
	if target:
		move_towards(target.global_position, chase_speed)
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
			return_to_path()
	if patrolling:
		get_parent().progress += delta * patrol_speed
		var direction = (global_position - previous_frame_position)
		direction = direction.normalized()
		adjust_direction(direction)
		move_detection_cone(-direction)
		previous_frame_position = global_position

func _process(_delta):
	if !target:
		for ray in detection_rays.get_children():
			if ray.is_colliding() and ray.get_collider().is_in_group("Player"):
				on_player_detection(ray.get_collider())
				alert()
	if !animating_action:
		if velocity or patrolling:
			animate_movement("run")
		else: 
			animate_movement("idle")

func alert():
	$AudioStreamPlayer2D.play()
	$DetectionLabel.visible = true
	await get_tree().create_timer(0.7).timeout
	$DetectionLabel.visible = false

func move_towards(target_vector, speed):
	var direction = (target_vector - global_position).normalized()
	velocity = direction * speed
	adjust_direction(direction)
	move_detection_cone(-velocity)
	move_and_slide()

func adjust_direction(direction):
	if direction.x > 0.7:
		facing = Direction.RIGHT
	if direction.x < -0.7:
		facing = Direction.LEFT
	if direction.y < -0.7:
		facing = Direction.UP
	if direction.y > 0.7:
		facing = Direction.DOWN

func animate_movement(state):
	if facing == Direction.RIGHT:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_right")
	if facing == Direction.LEFT:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play(state + "_right")
	if facing == Direction.DOWN:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_down")
	if facing == Direction.UP:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_up")

func animate_action(action):
	animating_action = true
	if facing == Direction.RIGHT:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(action + "_right")
	if facing == Direction.LEFT:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play(action + "_right")
	if facing == Direction.DOWN:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(action + "_down")
	if facing == Direction.UP:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(action + "_up")
	await $AnimationPlayer.animation_finished
	animating_action = false

func move_detection_cone(input_velocity):
	detection_rays.rotation = atan2(-input_velocity.x, input_velocity.y)

func on_player_detection(player):
	if patrolling:
		patrolling = false
		detection_position = global_position
	elif pathfinding:
		pathfinding = false
	eggseeking = false
	target = player

func on_egg_detection(egg_position):
	if !target:
		if patroller: 
			patrolling = false
			detection_position = global_position
		navigation_agent.set_target_position(egg_position)
		eggseeking = true
	
func on_crossword_detection():
	if !target:
		if patroller:
			patrolling = false
		await get_tree().create_timer(15.0).timeout
		patrolling = true
	
func _on_detection_area_body_exited(body):
	if body == target:
		return_to_path()
		target = null

func return_to_path():
	if patroller: 
		navigation_agent.set_target_position(detection_position)
	else:
		navigation_agent.set_target_position(spawn_point)
	pathfinding = true

func take_hit(damage, attacker):
	health -= damage
	animate_action("hit")
	target = attacker
	if health <= 0:
		die()

func die():
	animate_action("death")
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("death_fade")
	queue_free()

#func _on_player_caught(body):
#	if body.name == "Player":
#		body.position = body.spawn_point
#		player_target = null
#		if patroller:
#			spawn_point = get_parent().global_position
#			patrolling = true
#		global_position = spawn_point
#		clear_inventory.emit()
