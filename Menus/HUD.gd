extends Node2D

var points_displayed

func _ready():
	display_points()

func _process(_delta):
	if Global.points != points_displayed:
		display_points()

func display_points():
	$PointsDisplay.text = str(Global.points) + " points"
	points_displayed = Global.points
