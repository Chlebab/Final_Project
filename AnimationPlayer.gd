extends AnimationPlayer

@onready var sprite = get_parent().get_node("Sprite2D")
@onready var parent = get_parent()

enum Direction {UP, DOWN, LEFT, RIGHT}

var animating_action = false

var animation_dictionary = {
	Direction.RIGHT : {
		"flipped" : false,
		"idle" : "idle_right",
		"run" : "run_right",
		"attack" : "attack_right",
		"hit" : "hit_right",
		"die" : "die_right",
	},
	Direction.LEFT : {
		"flipped" : true,
		"idle" : "idle_right",
		"run" : "run_right",
		"attack" : "attack_right",
		"hit" : "hit_right",
		"die" : "die_right",
	},
	Direction.DOWN : {
		"flipped" : false,
		"idle" : "idle_down",
		"run" : "run_down",
		"attack" : "attack_down",
		"hit" : "hit_down",
		"die" : "die_down",
	},
	Direction.UP : {
		"flipped" : false,
		"idle" : "idle_up",
		"run" : "run_up",
		"attack" : "attack_up",
		"hit" : "hit_up",
		"die" : "die_up",
	},
}

func animate(state):
	if is_an_action(state):
		animating_action = true
	if !animating_action or is_an_action(state):
		sprite.flip_h = animation_dictionary[parent.facing]["flipped"]
		play(animation_dictionary[parent.facing][state])
	if is_an_action(state):
		await animation_finished
		if state != "die":
			animating_action = false

func is_an_action(state):
	return state == "attack" or state == "hit" or state == "die"
