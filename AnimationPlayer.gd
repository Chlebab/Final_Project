extends AnimationPlayer

var animating_action = false

@onready var sprite = get_parent().get_node("Sprite2D")
@onready var parent = get_parent()

enum Direction {UP, DOWN, LEFT, RIGHT}

func movement(state):
	if !animating_action:
		if parent.facing == Direction.RIGHT:
			sprite.flip_h = false
			play(state + "_right")
		if parent.facing == Direction.LEFT:
			sprite.flip_h = true
			play(state + "_right")
		if parent.facing == Direction.DOWN:
			sprite.flip_h = false
			play(state + "_down")
		if parent.facing == Direction.UP:
			sprite.flip_h = false
			play(state + "_up")

func action(command):
	animating_action = true
	if parent.facing == Direction.RIGHT:
		sprite.flip_h = false
		play(command + "_right")
	if parent.facing == Direction.LEFT:
		sprite.flip_h = true
		play(command + "_right")
	if parent.facing == Direction.DOWN:
		sprite.flip_h = false
		play(command + "_down")
	if parent.facing == Direction.UP:
		sprite.flip_h = false
		play(command + "_up")
	await animation_finished
	if command != "die":
		animating_action = false
