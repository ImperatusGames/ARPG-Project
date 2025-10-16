extends Node2D
class_name HealthComponent

@export var max_health : int
@export var current_health : int

signal health_empty
signal health_changed(current_health)

func _ready():
	current_health = max_health
	emit_signal("health_changed", current_health)
	
func damage(attack: Attack):
	current_health -= attack.attack_damage
	print("Health current: ", current_health)
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		emit_signal("health_empty")

func new_damage(total: int):
	current_health -= total
	print("Current Health: ", current_health)
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		emit_signal("health_empty")

func restore_health(heal: HealEffect):
	if heal.is_spell_heal == false:
		if heal.heal_power + current_health > max_health:
			current_health = max_health
			print("Healed for: ", max_health - current_health)
			print("Overhealed for: ", (heal.heal_power - (max_health - current_health)))
		else:
			current_health += heal.heal_power
			print("Healed for: ", heal.heal_power)
		emit_signal("health_changed", current_health)
	else:
		if (heal.heal_power * heal.heal_factor) > max_health:
			current_health = max_health
			print("Healed for: ", max_health - current_health)
			print("Overhealed for: ", ((heal.heal_power * heal.heal_factor) - (max_health - current_health)))
		else:
			current_health += (heal.heal_power * heal.heal_factor)
			print("Healed for: ", (heal.heal_power * heal.heal_factor))
		emit_signal("health_changed", current_health)
			
#If a Heal comes from an item, it will not utilize spell_power or factor, which modify the base heal amount
