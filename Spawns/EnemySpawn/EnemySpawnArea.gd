extends Node2D


@onready var skeleton = preload("res://Enemies/Skeleton/Skeleton.tscn")

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		print("Player entered")
		spawn_enemy()

func spawn_enemy():
	var instance = skeleton.instantiate()
	call_deferred("add_child", instance)
