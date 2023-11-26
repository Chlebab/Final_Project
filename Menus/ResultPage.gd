extends Control

var score = 0
var time_taken = 120-Global.time

func _process(delta):
	score = Global.points + (10*Global.time)
	
func _ready():
	$PlayAgain.grab_focus()
	$Points.text = str("POINTS  ", Global.points)
	$Time.text = str("TIME  ", time_taken, "secs")
	$Score.text = str("SCORE  ", score)

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Levels/DungeonLevel.tscn")
	

func _on_quit_pressed():
	get_tree().quit()
