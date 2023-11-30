extends Node2D

var player_in_chest_area = false
var chest_open = false
var money_in_chest = true

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		open_chest()
		take_money()
		
func _on_chest_area_body_entered(body):
	if body.get_name() == "Player":
		var inv_msg_label = body.get_node("InvMsg")
		var inv_msg_timer = body.get_node("InvMsgTimer")
		inv_msg_label.text = "[e] to open chest!"
		inv_msg_timer.start()
		player_in_chest_area = true
		
func _on_chest_area_body_exited(body):
	if body.get_name() == "Player":
		player_in_chest_area = false

func open_chest():
	if player_in_chest_area == true && chest_open == false:
		$GoldChest.play("Open")
		await get_tree().create_timer(0.1).timeout
		chest_open = true
		
func take_money():
	if chest_open == true && player_in_chest_area == true && money_in_chest == true:
		$EmptyChest.show()
		$GoldChest.hide()
		$EmptyChest.play("empty")
		money_in_chest = false
		Global.points += 400
		



	


