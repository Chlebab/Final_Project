extends Node2D
var speed = 1
var player_entering = false
var level = "LEVEL 3"
var description = "Goblins on patrol are easily distracted with a jack-in-the-box."
var paused = false

@onready var pause_menu = $Camera/HUD/Pause
@onready var player = $Player

func _ready():
	Global.lives_remaining = 3
	$Transition.play("fade_in")
	$Camera/HUD/LevelLabel.text = level
	$Camera/HUD/DescriptionLabel.text = description
	await get_tree().create_timer(1).timeout
	$Camera/HUD/LevelLabel.show()
	$Camera/HUD/DescriptionLabel.show()
	await get_tree().create_timer(4.5).timeout
	$Camera/HUD/LevelLabel.hide()
	$Camera/HUD/DescriptionLabel.hide()
	await get_tree().create_timer(1).timeout
	player.entering_level = true
	player.animate.movement("run")
	await get_tree().create_timer(2).timeout
	player.facing = 1
	player.entering_level = false

func _process(delta):
	if player.entering_level:
		player.facing = 4
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



	
	
	


	
	

