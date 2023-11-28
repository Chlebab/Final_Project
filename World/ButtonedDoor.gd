extends StaticBody2D

@export var inv: Inventory
signal door_opened
var open = false



func _ready():
	pass 

func _process(_delta):
	pass
	

		
func open_door():
	if open == false:
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
		self.collision_layer = 2
		self.collision_mask = 2
		open = false
		
func toggle_door():
	if $Open.visible:
		close_door()
	else:
		open_door()

