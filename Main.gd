extends Node

@onready var current_scene = $MainMenu

func switch_scene(scene):
	var next_scene_resource = load("res://" + scene + ".tscn")
	var next_scene = next_scene_resource.instantiate()
	add_child(next_scene)
	current_scene.queue_free()
	current_scene = next_scene
