extends Control

@onready var main = $"../../"

func _ready():
	$VBoxContainer/Resume.grab_focus()

func _on_resume_pressed():
	main.pauseMenu()
	
func _on_quit_pressed():
	get_tree().quit()
