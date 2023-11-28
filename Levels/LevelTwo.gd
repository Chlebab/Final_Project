extends Node2D
var speed = 1
var player_entering = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Transition.play("fade_in")
	await get_tree().create_timer(1.5).timeout
	player_entering = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_entering:
		get_node("Player").global_position.y -= speed
	
	
	

