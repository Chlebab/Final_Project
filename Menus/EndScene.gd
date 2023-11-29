extends Node2D

var door_visible = false
var player_size = false
var speed = 2


func _ready():
	$Player.play("run")
	await get_tree().create_timer(2).timeout
	$DoorNode.show()
	await get_tree().create_timer(1).timeout
	door_visible = true
	await get_tree().create_timer(4).timeout
	player_size = true
	await get_tree().create_timer(1).timeout
	$DoorNode/ColorRect2/Door.play("open")
	await get_tree().create_timer(2).timeout
	$Player.hide()
	await get_tree().create_timer(4).timeout
	$End.show()
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://Menus/ResultPage.tscn")
	

func _process(delta):
	if door_visible:
		$DoorNode.show()
		$DoorNode.apply_scale(Vector2(1.015, 1.015))
		
	if player_size:
		$Player.apply_scale(Vector2(1.008, 1.008))
		$Player.global_position.y += speed

