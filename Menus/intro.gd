extends Node2D

var move_timer = 30.0
var speed = 5
		
func _process(delta):
	await get_tree().create_timer(15).timeout
	$Player.play("Run")
	$Enemy.play("Run")
	$Player.global_position.x += speed
	await get_tree().create_timer(1).timeout
	$Enemy.global_position.x += speed
		
		
func _ready():
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	$ColorRect/Text.hide()
	$ColorRect/Text2.show()
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	$ColorRect/Text2.hide()
	$ColorRect/Title.show()
	$Player.show()
	$Player.global_position.x += 20
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(7).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout

	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
