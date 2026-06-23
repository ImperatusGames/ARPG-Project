extends Spell
class_name Cure_Spell

@onready var health_component: HealthComponent = get_node("../HealthComponent")
@onready var status_manager: StatusManager = get_node("../StatusManager")

var heal_power : int
var magic_power : int
var timer

func _ready() -> void:
	timer = $Timer
	timer.connect("timeout", healing)
	
func healing():
	if health_component.current_health == health_component.max_health:
		pass
		#Create error failover to prevent the heal from occurring
	else:
		if aug_state == true:
			Heal.is_spell_heal = true
			Heal.heal_power = magic_power
			Heal.heal_factor = 0.5
			health_component.restore_health(Heal)
			status_manager.regen_start()
			print("Heal power: ", Heal.spell_power)
			print("Current health: ", health_component.current_health)
			print("Max health: ", health_component.max_health)
			print("Augment State: ", aug_state)
		else:
			Heal.is_spell_heal = true
			Heal.heal_power = magic_power
			Heal.heal_factor = 1.0
			health_component.restore_health(Heal)
			print("Heal power: ", Heal.spell_power)
			print("Current health: ", health_component.current_health)
			print("Max health: ", health_component.max_health)
			print("Augment State: ", aug_state)
