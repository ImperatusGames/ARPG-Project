extends Spell
class_name Cure_Spell

var heal_power : int
var magic_power : int
var timer

func _ready() -> void:
	timer = $Timer
	timer.connect("timeout", healing)
	
func healing():
	if get_parent().has_node("HealthComponent"):
		var health_component : HealthComponent = get_node("../HealthComponent")
		var stats_component : StatsComponent = get_node("../StatsComponent")
		if health_component.current_health == health_component.max_health:
			pass
			#Create error failover to prevent the heal from occurring
		else:
			Heal.is_spell_heal = true
			Heal.heal_power = magic_power
			Heal.heal_factor = 1.0
			health_component.restore_health(Heal)
			print("Heal power: ", Heal.spell_power)
			print("Current health: ", health_component.current_health)
			print("Max health: ", health_component.max_health)
