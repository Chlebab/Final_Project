extends Panel

var time: float = 15.0
var minutes: int = 0 
var seconds: int = 0
var msecs: int = 0
var flash_timer: float = 0
var flash_visible: bool = false
var flash_frequency: float = 0.5 
var points: int = 0

func _process(delta) -> void:
	time -= delta
	if time <= 0:
		time = 0
	#	if points > 10000:
	#		get_tree().change_scene_to_file(LevelTwo.tscn)
	#	else:
	#			get_tree().change_scene_to_file(GameOver.tscn)
		stop()
		
	msecs = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds
	$Miliseconds.text = "%02d" % msecs
	
	if time <= 5:
		flash_timer = fmod(time, flash_frequency * 2)
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
	
	
	if time <= 10:
		$Minutes.modulate = Color(1, 0, 0)
		$Seconds.modulate = Color(1, 0, 0)
		$Miliseconds.modulate = Color(1, 0, 0)
	else:
		$Minutes.modulate = Color(1, 1, 1)
		$Seconds.modulate = Color(1, 1, 1)
		$Miliseconds.modulate = Color(1, 1, 1)
	
func stop() -> void:
	set_process(false)
	get_tree().quit()

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msecs]
