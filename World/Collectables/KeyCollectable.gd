extends StaticBody2D

@export var item: InventoryItem
var player = null

func _on_interaction_area_body_entered(body):
	if body.has_method("player"):
		player = body
		playercollect()
		await get_tree().create_timer(0.3).timeout
		self.queue_free()

func playercollect():
	player.collect(item)
