extends Node2D

var speed = 1
var player_entering = false
var paused = false

@onready var pause_menu = $Player/Pause

func _ready():
	$Transition.play("fade_in")
	await get_tree().create_timer(1).timeout
	$Player/LevelLabel.show()
	$Player/DescriptionLabel.show()
	await get_tree().create_timer(4.5).timeout
	$Player/LevelLabel.hide()
	$Player/DescriptionLabel.hide()
	await get_tree().create_timer(1).timeout
	player_entering = true
	await get_tree().create_timer(1.2).timeout
	player_entering = false
	
func _process(delta):
	if player_entering:
		get_node("Player").global_position.y += speed
	elif Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused	

