extends StaticBody2D

@export var inv: Inventory
signal door_opened
var open = false



func _ready():
	pass 

func _process(_delta):
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
	self.collision_layer = 8
	self.collision_mask = 8
	open = true
	
func close_door():
	if open == true:
		$Open.hide()
		$Close.show()
		$Close.play()
		self.collision_layer = 1
		self.collision_mask = 1
		open = false

func toggle_door():
	if $Open.visible:
		close_door()
	else:
		open_door()
