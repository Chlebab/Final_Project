extends Node2D

var points_displayed

func _ready():
	display_points()

func _process(_delta):
	if Global.points != points_displayed:
		display_points()
	if Global.lives_remaining == 2:
		$Lives/Life3.hide()
	elif Global.lives_remaining == 1:
		$Lives/Life2.hide()
	elif Global.lives_remaining == 0:
		$Lives/Life1.hide()

func display_points():
	$PointsDisplay.text = str(Global.points) + " points"
	points_displayed = Global.points
