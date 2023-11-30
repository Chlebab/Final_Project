extends Node2D


@onready var skeleton = preload("res://Enemies/Skeleton/Skeleton.tscn")
var enemySpawned = false

func _on_area_2d_body_entered(body):
	if body and not enemySpawned:
		print("Player entered")
		await get_tree().create_timer(1).timeout
		spawn_enemy()
		enemySpawned = true

func spawn_enemy():
	var instance = skeleton.instantiate()
	call_deferred("add_child", instance)
