extends Node2D

@onready var pause_menu = $Player/Pause

var paused = false

func _ready():
	$Music.play()
 
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
