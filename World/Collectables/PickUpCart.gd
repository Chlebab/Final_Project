extends StaticBody2D

signal drop_off_inv_at_cart
var player = null

func _on_interaction_area_body_entered(body):
	if body.has_method("player"):
		print("player in the dropoff vicinity")
		player = body
		drop_off_inv_at_cart.emit()
		
