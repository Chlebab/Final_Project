extends Node2D

var points_displayed

func _ready():
	display_points()

func _process(delta):
	if Global.points != points_displayed:
		display_points()
		
	if Global.lives_remaining == 2:
		$Lives/Life3.hide()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life3.show()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life3.hide()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life3.show()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life3.hide()
	elif Global.lives_remaining == 1:
		$Lives/Life2.hide()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life2.show()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life2.hide()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life2.show()
		await get_tree().create_timer(0.5).timeout
		$Lives/Life2.hide()
	elif Global.lives_remaining == 0:
		$Lives/Life1.hide()

func flash(life):
	$Lives/life.show()
	await get_tree().create_timer(0.5).timeout
	$Lives/life.hide()
	await get_tree().create_timer(0.5).timeout
	$Lives/life.show()

	

func display_points():
	$PointsDisplay.text = str(Global.points) + " points"
	points_displayed = Global.points
	

