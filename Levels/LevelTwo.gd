extends Node2D
var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Transition.play("fade_in")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Player").global_position.y -= speed
	
	

