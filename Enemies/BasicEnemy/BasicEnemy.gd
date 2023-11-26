extends CharacterBody2D

signal game_over
signal clear_inventory

var chase_speed = 50
var return_speed = 40
var patrol_speed = 40
var health = 60
var attack_damage = 20
var alive = true

var previous_frame_position # these two variables are to record the direction of 
var detection_position # movement while patrolling in order to adjust the enemy's vision

var patroller
var patrolling

var target
var pathfinding
var eggseeking
var attacking

@onready var spawn_point = global_position
@onready var detection_rays = $DetectionZones/DetectionRays
@onready var navigation_agent = $NavigationAgent2D
@onready var animate = $AnimationPlayer

func _ready():
	if get_parent() is PathFollow2D:
		patroller = true
		patrolling = true
		previous_frame_position = global_position

func _physics_process(delta):
	if alive:
		if target and !attacking:
			if global_position.distance_to(target.global_position) > 20:
				move_towards(target.global_position, chase_speed)
			else:
				attack()
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
			animate.adjust_direction(direction)
			move_detection_cone(-direction)
			previous_frame_position = global_position	

func _process(_delta):
	if alive:
		if !target:
			for ray in detection_rays.get_children():
				if ray.is_colliding() and ray.get_collider().is_in_group("Enemy of Goblins"):
					var body = ray.get_collider()
					if body.alive: on_target_detection(ray.get_collider())
					if body.is_in_group("Player"): alert()
		if velocity or patrolling:
			animate.movement("run")
		else: 
			animate.movement("idle")

func alert():
	$AlertSound.play()
	$DetectionLabel.visible = true
	await get_tree().create_timer(0.7).timeout
	$DetectionLabel.visible = false

func move_towards(target_vector, speed):
	var direction = (target_vector - global_position).normalized()
	velocity = direction * speed
	animate.adjust_direction(direction)
	move_detection_cone(-velocity)
	move_and_slide()

func move_detection_cone(input_velocity):
	detection_rays.rotation = atan2(-input_velocity.x, input_velocity.y)

func on_target_detection(new_target):
	if patrolling:
		patrolling = false
		detection_position = global_position
	pathfinding = false
	eggseeking = false
	target = new_target
	print(target)

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

func attack():
	attacking = true
	animate.action("attack")
	$SwordSound.play()
	target.take_hit(attack_damage, self)
	if target.health <= 0:
		target = null
		return_to_path()
	await get_tree().create_timer(1.0).timeout
	attacking = false

func take_hit(damage, attacker):
	health -= damage
	if health > 0:
		if !attacking: animate.action("hit")
		if target != attacker: on_target_detection(attacker)
	else: 
		die()

func die():
	animate.action("death")
	alive = false
	$CollisionShape2D.disabled = true
