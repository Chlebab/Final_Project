extends StaticBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	_animated_sprite.play("default")

func _on_timer_timeout():
	queue_free()

func _on_interaction_area_body_entered(body):
	if body.has_method("on_crossword_detection"):
		body.on_crossword_detection()
