extends CharacterBody2D

@export var inv: Inventory
@export var speed = 80.0
@export var spawn_point = Vector2(0,0)

var apple = preload("res://World/Collectables/AppleCollectable.tscn")
var egg = preload("res://World/Useables/EggUseable.tscn")

signal update_slots


func _ready():
	display_points()

func _physics_process(_delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	velocity.x = direction_x
	velocity.y = direction_y
	velocity = velocity.normalized() * speed
	move_and_slide()

func player():
	pass
	
func collect(item):
	Global.points += item.points
	inv.insert(item)
	display_points()

func display_points():
	$PointsDisplay.text = str(Global.points) + " points"
	pass
	
func _on_enemy_navigator_clear_inventory():
	print("You have been cought. Your inventory has been taken.")
	empty_inventory()

func empty_inventory():
	for i in range(10):
		inv.slots[i].item = null
	update_slots.emit()


func _on_pick_up_cart_drop_off_inv_at_cart():
	print("You have reached the drop off point. Your inventory has been packed to the cart.")
	empty_inventory()

func _process(_delta):
	if Input.is_action_just_pressed("r"):
		use_egg_item()

func reduce_amount_by_1(i):
	if inv.slots[i].amount > 1:
		inv.slots[i].amount -= 1
	else:
		inv.slots[i].item = null
	update_slots.emit()

func use_egg_item():
	var egg_slot = -1
	print("r pressed, use egg function triggered")
	for i in inv.slots.size():
		if inv.slots[i].item and str(inv.slots[i].item.name) == "Egg":
			egg_slot = i
			break
	if egg_slot != -1:
		print("You got yourself an egg in slot ", inv.slots[egg_slot].item)
		
		var egg_instance = egg.instantiate()
		egg_instance.position = global_position
		get_parent().add_child(egg_instance)
#		$InvMsg.text = "Egg used"
		reduce_amount_by_1(egg_slot)
	else:
		print("No egg found in the inventory")
#		$Label.text = "No egg found in the inventory"
