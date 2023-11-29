extends Node2D

var speed = 2
var player_entering = false
var paused = false

@onready var pause_menu = $Camera/HUD/Pause
@onready var player = $Player

func _ready():
	$Transition.play("fade_in")
	await get_tree().create_timer(1).timeout
	$Camera/HUD/LevelLabel.show()
	$Camera/HUD/DescriptionLabel.show()
	await get_tree().create_timer(4.5).timeout
	$Camera/HUD/LevelLabel.hide()
	$Camera/HUD/DescriptionLabel.hide()
	await get_tree().create_timer(1).timeout
	player_entering = true
	player.animate.movement("run")
	await get_tree().create_timer(2).timeout
	player_entering = false
	player.alive = true
	
func _process(_delta):
	if player_entering:
		player.alive = false
		player.global_position.y += speed
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


