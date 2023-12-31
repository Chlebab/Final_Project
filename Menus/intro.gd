extends Node2D

var move_timer = 30.0
var speed = 5
		
func _process(delta):
	await get_tree().create_timer(11).timeout
	$Player.play("Run")
	$Enemy.play("Run")
	$Player.global_position.x += speed
	await get_tree().create_timer(1).timeout
	$Enemy.global_position.x += speed

func _ready():

	await get_tree().create_timer(4).timeout
	$AnimationPlayer.play("fade")
	$AnimationPlayer.play("fadeout")
	$ColorRect/Text2.show()
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(4).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(2).timeout
	$ColorRect/Text2.hide()
	$ColorRect/Title.show()
	$Player.show()
	$Player.global_position.x += 20
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(7).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout

	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
