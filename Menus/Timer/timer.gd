extends Panel


var minutes: int = 0 
var seconds: int = 0
var msecs: int = 0
var flash_timer: float = 0
var flash_visible: bool = false
var flash_frequency: float = 0.5 


func _process(delta) -> void:
	Global.time -= delta
	if Global.time <= 0:
		Global.time = 0
	#	if points > 10000:
	#		get_tree().change_scene_to_file(LevelTwo.tscn)
	#	else:
	#			get_tree().change_scene_to_file(GameOver.tscn)
		stop()
		
	msecs = fmod(Global.time, 1) * 100
	seconds = fmod(Global.time, 60)
	minutes = fmod(Global.time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds
	$Miliseconds.text = "%02d" % msecs
	
	if Global.time <= 5:
		flash_timer = fmod(Global.time, flash_frequency * 2)
		flash_visible = flash_timer < flash_frequency
		$Minutes.visible = flash_visible
		$Seconds.visible = flash_visible
		$Miliseconds.visible = flash_visible
		$Minutes.modulate = Color(1, 0, 0)  # Red
		$Seconds.modulate = Color(1, 0, 0)
		$Miliseconds.modulate = Color(1, 0, 0)
	else:
		$Minutes.modulate = Color(1, 1, 1)
		$Seconds.modulate = Color(1, 1, 1)
		$Miliseconds.modulate = Color(1, 1, 1)
	
	
	if Global.time <= 10:
		$Minutes.modulate = Color(1, 0, 0)
		$Seconds.modulate = Color(1, 0, 0)
		$Miliseconds.modulate = Color(1, 0, 0)
	else:
		$Minutes.modulate = Color(1, 1, 1)
		$Seconds.modulate = Color(1, 1, 1)
		$Miliseconds.modulate = Color(1, 1, 1)
	
func stop() -> void:
	set_process(false)
	get_tree().change_scene_to_file("res://Menus/ResultPage.tscn")

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msecs]
