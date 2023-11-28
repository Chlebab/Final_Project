extends Node2D

signal toggle_door
signal open_door

var open = false
var player_in_area = false

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		press_button()


func press_button():
	if player_in_area: 	
		toggle_door.emit()
		print(player_in_area)	


func _on_button_area_body_entered(body):
	if body.get_name() == "Player":
		var inv_msg_label = body.get_node("InvMsg")
		var inv_msg_timer = body.get_node("InvMsgTimer")
		inv_msg_label.text = "[E] to press button!"
		inv_msg_timer.start()
		player_in_area = true
		print(player_in_area)


func _on_button_area_body_exited(body):
	if body.get_name() == "Player":
		player_in_area = false
		print("player left button")
