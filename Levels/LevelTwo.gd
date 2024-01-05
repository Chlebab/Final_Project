extends Node2D
var speed = 1.3
var making_an_entrance
var level = "LEVEL 2"
var description = "FIND A WAY TO DISTRACT THE GOBLINS GUARDING THE DOOR!"
var paused = false

@onready var pause_menu = $Camera/HUD/Pause
@onready var player = $Player

func _ready():
	player.entering_level = true
	$Transition.play("fade_in")
	Global.lives_remaining = 3
	$Camera/HUD/LevelLabel.text = level
	$Camera/HUD/DescriptionLabel.text = description
	await get_tree().create_timer(1).timeout
	$Camera/HUD/LevelLabel.show()
	$Camera/HUD/DescriptionLabel.show()
	await get_tree().create_timer(4.5).timeout
	$Camera/HUD/LevelLabel.hide()
	$Camera/HUD/DescriptionLabel.hide()
	await get_tree().create_timer(1).timeout
	making_an_entrance = true
	player.animator.movement("run")
	await get_tree().create_timer(1).timeout
	making_an_entrance = false
	player.entering_level = false

func _process(delta):
	if making_an_entrance:
		player.global_position.y -= speed
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
