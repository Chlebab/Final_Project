extends Control

signal start_game

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://LevelOne.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/Options.tscn")

func _on_quit_pressed():
	get_tree().quit()



