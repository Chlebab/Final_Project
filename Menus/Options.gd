extends Control

func _ready():
	$VBoxContainer/Controls.grab_focus()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
	
