extends Spell
class_name Defender_Spell

var timer

func _ready() -> void:
	timer = $Timer
	timer.timeout.connect(timer_expired)

func spell_cast():
	var active : bool = is_active()
	if active == true:
		timer.start()
	else:
		defense_boost()
		timer.start()

func is_active():
	if timer.is_stopped() == true:
		return false
	else:
		return true

func timer_expired():
	defense_restore()

func defense_boost():
	pass
	#Connect to player to increase defense for duration

func defense_restore():
	pass
	#Connect to player to restore defense to base after duration
