extends CharacterBody2D

var speed = 80
var health = 80
var attack_damage = 20
var attacking

var target

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.DOWN

@onready var animate = $AnimationPlayer

func _physics_process(_delta):
	if target and !attacking:
		if global_position.distance_to(target.global_position) > 20:
			move_towards(target.global_position)
		else:
			attack()
		animate.movement("run")
	else:
		animate.movement("idle")

func move_towards(target_vector):
	var direction = (target_vector - global_position).normalized()
	velocity = direction * speed
	animate.adjust_direction(direction)
	move_and_slide()

func _on_target_detection(body):
	if body.is_in_group("Living"):
		target = body

func take_hit(damage, attacker):
	health -= damage
	if health > 0:
		animate.action("hit")
		target = attacker
	else:
		die()

func attack():
	attacking = true
	animate.action("attack")
	target.take_hit(attack_damage, self)
	if target.health <= 0:
		target = false
		velocity = Vector2(0,0)
	await get_tree().create_timer(1.0).timeout
	attacking = false

func die():
	animate.action("die")
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("death_fade")
	queue_free()
