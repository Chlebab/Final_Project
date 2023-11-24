extends StaticBody2D

@export var inv: Inventory

func _ready():
	pass 

func _process(_delta):
	pass

func _on_door_area_body_entered(body):
	print("Player entered")
	if body.get_name() == "Player":
		for i in body.inv.slots.size():
			if body.inv.slots[i].item and str(body.inv.slots[i].item.name) == "Key":
				$Close.hide()
				$Open.show()
				$Open.play()
	
func _on_door_area_body_exited(body):
	print("Player exited")
	if body.get_name() == "Player":
		$Open.hide()
		$Close.show()
		$Close.play()
	
