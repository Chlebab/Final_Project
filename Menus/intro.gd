extends Node2D


func _ready():
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	$ColorRect/Sprite2D.text = "gkjfgkjf"
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
