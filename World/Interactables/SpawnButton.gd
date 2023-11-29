extends Node2D

signal spawn_enemy

var player_in_area = false

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		press_button()


func press_button():
	if player_in_area: 	
		spawn_enemy.emit()
		print("player pressed button")	


func _on_button_area_body_entered(body):
	if body.get_name() == "Player":
		var inv_msg_label = body.get_node("InvMsg")
		var inv_msg_timer = body.get_node("InvMsgTimer")
		inv_msg_label.text = "[O] to press button!"
		inv_msg_timer.start()
		player_in_area = true
		print("player in button")


func _on_button_area_body_exited():
	player_in_area = false
	print("player left button")
