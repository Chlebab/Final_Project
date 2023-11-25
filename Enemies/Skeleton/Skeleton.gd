extends CharacterBody2D

var speed = 80

var attack_damage = 20
var attacking
var animating_action = false

var target

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.DOWN

func _physics_process(_delta):
	if target:
		if global_position.distance_to(target.global_position) > 20:
			move_towards(target.global_position)
		else: 
			if !attacking:
				attacking = true
				attack()
				if target.health <= 0:
					target = null
					velocity = Vector2(0,0)
				await get_tree().create_timer(1.0).timeout
				attacking = false
	if !animating_action:
		if velocity:
			animate_movement("run")
		else:
			animate_movement("idle")

func move_towards(target_vector):
	var direction = (target_vector - global_position).normalized()
	velocity = direction * speed
	adjust_direction(direction)
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
		$AnimationPlayer.play(action + "_left")
	if facing == Direction.DOWN:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(action + "_down")
	if facing == Direction.UP:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(action + "_up")
	await $AnimationPlayer.animation_finished
	animating_action = false

func _on_target_detection(body):
	if body.is_in_group("Living"):
		target = body

func attack():
	animate_action("attack")
	target.take_hit(attack_damage, self)
