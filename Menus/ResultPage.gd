extends Control

var score = 0
var time_taken = 120-Global.time

func _process(delta):
	pass
	
func _ready():
	$PlayAgain.grab_focus()
	$Points.text = str("POINTS  ", Global.points)
	await get_tree().create_timer(1).timeout
	$Points.show()
	$Time.text = str("TIME  ", time_taken, "secs")
	await get_tree().create_timer(1).timeout
	$Time.show()
	score = Global.points + (10*Global.time)
	$Score.text = str("SCORE  ", score)
	await get_tree().create_timer(1).timeout
	$Score.show()
	await get_tree().create_timer(1).timeout
	$PlayAgain.show()
	$Quit.show()
	
	

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
	

func _on_quit_pressed():
	get_tree().quit()
