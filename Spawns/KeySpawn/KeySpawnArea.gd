extends Node2D


@onready var key = preload("res://World/Collectables/KeyCollectable.tscn")
@onready var key_item = preload("res://Inventory/Items/Key.tres")

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		print("Player entered")
		spawn_key()

func spawn_key():
	var instance = key.instantiate()
	add_child(instance)
	#print(instance.points)



