extends Spell
class_name Defender_Spell

var stats_component : StatsComponent

var timer

func _ready() -> void:
	timer = $Timer
	timer.timeout.connect(timer_expired)
	#spell_cast()

func spell_cast():
	if stats_component.protect_status == true:
		timer.start()
		print("Defend Timer Refreshed!")
	else:
		defense_boost()
		timer.start()
		print("Defend Timer Started!")

func timer_expired():
	defense_restore()
	print("Defend Timer Expired!")
	call_deferred("queue_free")

func defense_boost():
	stats_component.protect_status = true
	stats_component.set_defense_bonus_on()
	print("Defense Boosted!")

func defense_restore():
	stats_component.protect_status = false
	stats_component.set_defense_bonus_off()
	print("Defense Restored!")
