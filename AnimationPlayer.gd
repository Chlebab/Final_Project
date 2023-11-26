extends AnimationPlayer

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.UP

var animating_action = false

@onready var sprite = get_parent().get_node("Sprite2D")

func adjust_direction(direction):
	if direction.x > 0.7:
		facing = Direction.RIGHT
	if direction.x < -0.7:
		facing = Direction.LEFT
	if direction.y < -0.7:
		facing = Direction.UP
	if direction.y > 0.7:
		facing = Direction.DOWN

func movement(state):
	if !animating_action:
		if facing == Direction.RIGHT:
			sprite.flip_h = false
			play(state + "_right")
		if facing == Direction.LEFT:
			sprite.flip_h = true
			play(state + "_right")
		if facing == Direction.DOWN:
			sprite.flip_h = false
			play(state + "_down")
		if facing == Direction.UP:
			sprite.flip_h = false
			play(state + "_up")

func action(action):
	animating_action = true
	if facing == Direction.RIGHT:
		sprite.flip_h = false
		play(action + "_right")
	if facing == Direction.LEFT:
		sprite.flip_h = true
		play(action + "_right")
	if facing == Direction.DOWN:
		sprite.flip_h = false
		play(action + "_down")
	if facing == Direction.UP:
		sprite.flip_h = false
		play(action + "_up")
	await animation_finished
	if action != "die":
		animating_action = false
