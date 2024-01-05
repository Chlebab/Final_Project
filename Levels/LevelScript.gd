extends Node2D

var paused = false
var making_an_entrance

@onready var pause_menu = $Camera/HUD/Pause
@onready var player = $Player

@export var level: String
@export var description: String
@export var speed: float
@export var entrance_duration: float

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
	if level != "LEVEL 4":
		await get_tree().create_timer(1).timeout
	making_an_entrance = true
	player.animator.movement("run")
	await get_tree().create_timer(entrance_duration).timeout
	player.entering_level = false
	making_an_entrance = false

func _process(_delta):
	if making_an_entrance and level == "LEVEL 2":
		player.global_position.y -= speed
	elif making_an_entrance:
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
