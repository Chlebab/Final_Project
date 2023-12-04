extends AnimationPlayer

var animating_action = false

@onready var sprite = get_parent().get_node("Sprite2D")
@onready var parent = get_parent()

enum Direction {UP, DOWN, LEFT, RIGHT}

var movement_dictionary = {
	Direction.RIGHT : {
		"flipped" : false,
		"idle" : "idle_right",
		"run" : "run_right",
	},
	Direction.LEFT : {
		"flipped" : true,
		"idle" : "idle_right",
		"run" : "run_right",
	},
	Direction.DOWN : {
		"flipped" : false,
		"idle" : "idle_down",
		"run" : "run_down",
	},
	Direction.UP : {
		"flipped" : false,
		"idle" : "idle_up",
		"run" : "run_up"
	}
}

func movement(state):
	if !animating_action:
		sprite.flip_h = movement_dictionary[parent.facing]["flipped"]
		play(movement_dictionary[parent.facing][state])

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
