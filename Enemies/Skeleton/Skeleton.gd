extends CharacterBody2D

var speed = 80
var health = 60
var attack_damage = 20
var alive = true

var target
var attacking

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.DOWN

@onready var animator = $AnimationPlayer
@onready var navigator = $NavigationAgent2D

func _physics_process(_delta):
	if alive:
		if target and !attacking:
			if target.global_position.distance_to(navigator.target_position) > 40:
				navigator.set_target_position(target.global_position)
			if global_position.distance_to(target.global_position) > 20:
				move_towards(target.global_position)
			else:
				attack()
			animator.movement("run")
		else:
			animator.movement("idle")

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
	
func _on_target_detection(body):
	if body.is_in_group("Living") and body.alive:
		target = body
		navigator.set_target_position(target.global_position)

func take_hit(damage, attacker):
	health -= damage
	if health > 0:
		if !attacking: animator.action("hit")
		if !target:
			target = attacker
	else:
		die()

func attack():
	attacking = true
	adjust_direction(target.global_position - global_position)
	animator.action("attack")
	$SwordSound.play()
	target.take_hit(attack_damage, self)
	if target.health <= 0:
		target = false
		velocity = Vector2(0,0)
	await get_tree().create_timer(0.8).timeout
	attacking = false

func die():
	animator.action("die")
	alive = false
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(1.0).timeout
#	$AnimationPlayer.play("death_fade") TO-DO
