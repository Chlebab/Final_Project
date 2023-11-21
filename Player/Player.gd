extends CharacterBody2D

@export var inv: Inventory
@export var speed = 80.0
@export var spawn_point = Vector2(0,0)

signal update_slots

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
	inv.insert(item)

func _on_enemy_navigator_clear_inventory():
	print("You have been cought. Your inventory has been taken")
	for i in range(10):
		inv.slots[i].item = null
	update_slots.emit()
