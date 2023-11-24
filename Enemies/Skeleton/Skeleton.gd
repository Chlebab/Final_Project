extends CharacterBody2D

var target
var speed = 80

@onready var detection_rays = $DetectionZones/DetectionRays

func _physics_process(_delta):
	if target:
		if global_position.distance_to(target.global_position) > 20:
			move_towards(target.global_position)
#		else: 
#			attack(target)

func _process(_delta):
	if !target:
		for ray in detection_rays.get_children():
			if ray.is_colliding() and ray.get_collider().is_in_group("Living"):
				on_target_detection(ray.get_collider())

func move_towards(target_vector):
	var direction = (target_vector - global_position).normalized()
	animate_movement(direction)
	velocity = direction * speed
	move_detection_cone(-velocity)
	move_and_slide()

func animate_movement(direction):
#	if direction.x > 0.7:
#		$AnimationPlayer.play("running_right")
#	elif direction.x < -0.7:
#		$AnimationPlayer.play("running_left")
#	elif direction.y > 0:
#		$AnimationPlayer.play("running_down")
#	else:
#		$AnimationPlayer.play("running_up")
	pass

func move_detection_cone(input_velocity):
#	detection_rays.rotation = atan2(-input_velocity.x, input_velocity.y)
	pass

func on_target_detection(body):
	target = body
