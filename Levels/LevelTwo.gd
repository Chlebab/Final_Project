extends Node2D
var speed = 1
var player_entering = false
var intro_text = "Level 2 The Goblins have congregated /b near the Escape door"
# Called when the node enters the scene tree for the first time.
func _ready():
	$Transition.play("fade_in")
	$Player/Intro.text = intro_text
	await get_tree().create_timer(1).timeout
	$Player/Intro.show()
	await get_tree().create_timer(4.5).timeout
	$Player/Intro.hide()
	await get_tree().create_timer(1).timeout
	player_entering = true
	await get_tree().create_timer(1.2).timeout
	player_entering = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_entering:
		get_node("Player").global_position.y -= speed
	
	
	

