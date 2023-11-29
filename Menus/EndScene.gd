extends Node2D

var door_visible = false
var player_size = false
var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.play("stand")
	await get_tree().create_timer(1).timeout
	$Player.play("run")
	await get_tree().create_timer(2).timeout
	$DoorNode.show()
	await get_tree().create_timer(0.8).timeout
	door_visible = true
	await get_tree().create_timer(2).timeout
	player_size = true
	
	await get_tree().create_timer(3).timeout
	$Player.hide()
	await get_tree().create_timer(1).timeout
	$DoorNode/ColorRect2/Door.play("open")

func _process(delta):
	if door_visible:
		$DoorNode.show()
		$DoorNode.apply_scale(Vector2(1.008, 1.008))
		
	if player_size:
		$Player.apply_scale(Vector2(1.008, 1.008))
		$Player.global_position.y += speed

