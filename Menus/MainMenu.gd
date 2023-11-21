extends Control

signal start_game

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	start_game.emit("LevelOne")

func _on_quit_pressed():
	get_tree().quit()
