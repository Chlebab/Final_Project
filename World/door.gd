extends StaticBody2D

@export var inv: Inventory
signal door_opened



func _ready():
	pass 

func _process(delta):
	pass

func _on_door_area_body_entered(body):
	print("Player entered")
	if body.get_name() == "Player":
		for i in body.inv.slots.size():
			if body.inv.slots[i].item and str(body.inv.slots[i].item.name) == "Key":
				open_door()
				
func _on_door_area_body_exited(body):
	print("Player exited")
	if body.get_name() == "Player":
		close_door()
		
func open_door():
	$Close.hide()
	$Open.show()
	$Open.play()
	self.collision_layer = 2
	self.collision_mask = 2
	
func close_door():
	$Open.hide()
	$Close.show()
	$Close.play()
	self.collision_layer = 1
	self.collision_mask = 1
