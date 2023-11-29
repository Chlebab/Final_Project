extends Node2D
var speed = 1
var player_entering = false
var level = "LEVEL 2"
var description = "FIND A WAY TO LURE THE GUARDS AND LOCK THEM IN A ROOM!"
var paused = false

@onready var pause_menu = $Camera/HUD/Pause

func _ready():
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
	player_entering = true
	await get_tree().create_timer(1.2).timeout
	player_entering = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_entering:
		get_node("Player").global_position.y -= speed
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



	
	
	

