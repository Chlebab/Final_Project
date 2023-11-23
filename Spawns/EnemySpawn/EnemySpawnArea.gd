extends Node2D


@onready var basic_enemy = preload("res://Enemies/BasicEnemy/BasicEnemy.tscn")

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		print("Player entered")
		spawn_enemy()

func spawn_enemy():
	var instance = basic_enemy.instantiate()
	add_child(instance)








