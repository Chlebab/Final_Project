extends CharacterBody2D

@export var inv: Inventory
@export var speed = 80.0
@export var spawn_point = Vector2(0,0)

var egg = preload("res://World/Useables/EggUseable.tscn")
var crossword = preload("res://World/Useables/CrosswordUseable.tscn")

enum Direction {UP, DOWN, LEFT, RIGHT}
var facing = Direction.UP

var alive = true
var health = 20

signal update_slots

func _ready():
	display_points()
	$BarrelSprite.visible = false

func _physics_process(_delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	velocity.x = direction_x
	velocity.y = direction_y
	velocity = velocity.normalized() * speed
	adjust_direction(velocity)
	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("r"):
		use_egg_item()
	elif Input.is_action_just_pressed("f"):
		use_crossword_item()
	elif Input.is_action_just_pressed("b"):
		use_barrel_item()
	if alive:
		if velocity:
			animate("run")
		else:
			animate("idle")

func adjust_direction(direction):
	if direction.x > 0.7:
		facing = Direction.RIGHT
	if direction.x < -0.7:
		facing = Direction.LEFT
	if direction.y < -0.7:
		facing = Direction.UP
	if direction.y > 0.7:
		facing = Direction.DOWN

func animate(state):
	if facing == Direction.RIGHT:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_right")
	if facing == Direction.LEFT:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play(state + "_right")
	if facing == Direction.DOWN:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_down")
	if facing == Direction.UP:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play(state + "_up")

func player():
	pass

func collect(item):
	Global.points += item.points
	inv.insert(item)
	display_points()

func display_points():
	$PointsDisplay.text = str(Global.points) + " points"

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
		reduce_amount_by_1(egg_slot)
		$InvMsg.text = "Egg used!"
		$InvMsgTimer.start()
	else:
		print("No egg found in the inventory")
		$InvMsg.text = "No egg found in the inventory"
		$InvMsgTimer.start()

func use_crossword_item():
	var crossword_slot = -1
	print("f pressed, use crossword function triggered")
	for i in inv.slots.size():
		if inv.slots[i].item and str(inv.slots[i].item.name) == "Crossword":
			crossword_slot = i
			break
	if crossword_slot != -1:
		print("You got yourself a crossword in slot ", inv.slots[crossword_slot].item)
		var crossword_instance = crossword.instantiate()
		crossword_instance.position = global_position
		get_parent().add_child(crossword_instance)
		reduce_amount_by_1(crossword_slot)
		$InvMsg.text = "Crossword used!"
		$InvMsgTimer.start()
	else:
		print("No crossword found in the inventory")
		$InvMsg.text = "No crossword found in the inventory"

func use_barrel_item():
	var barrel_slot = -1
	print("b pressed, use barrel function triggered")
	for i in inv.slots.size():
		if inv.slots[i].item and str(inv.slots[i].item.name) == "Barrel":
			barrel_slot = i
			break
	if barrel_slot != -1:
		print("You got yourself a barrel in slot ", inv.slots[barrel_slot].item)
		reduce_amount_by_1(barrel_slot)
		$Sprite2D.visible = false
		$BarrelSprite.visible = true
		$InvMsg.text = "Barrel used!"
		$InvMsgTimer.start()
#		set_collision_layer_value(9, true)
#		set_collision_mask_value(9, true)
		await get_tree().create_timer(15.0).timeout
#		set_collision_layer_value(1, true)
#		set_collision_mask_value(1, true)
		$Sprite2D.visible = true
		$BarrelSprite.visible = false
	else:
		print("No barrel found in the inventory")
		$InvMsg.text = "No barrel found in the inventory"
		$InvMsgTimer.start()

func _on_inv_msg_timer_timeout():
	$InvMsg.text = ""

func take_hit(damage, _attacker):
	health -= damage
	if health <= 0:
		alive = false
		animate("die")
