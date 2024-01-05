extends Node2D
var speed = 2
var making_an_entrance
var level = "LEVEL 4"
var description = "FREEDOM IS WITHIN REACH BUT STAY CLEAR OF THE SARCOPHAGI!"
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
	making_an_entrance = true
	player.facing = 1
	player.animator.movement("run")
	print(player.facing)
	await get_tree().create_timer(1.7).timeout
	player.entering_level = false
	making_an_entrance = false

func _process(_delta):
	if making_an_entrance:
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

