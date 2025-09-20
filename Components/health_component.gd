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

func heal(heal_amount: int):
	if heal_amount + current_health > max_health:
		current_health = max_health
		print("Healed for: ", max_health - current_health)
		print("Overhealed for: ", (heal_amount - (max_health - current_health)))
	else:
		current_health += heal_amount
		print("Healed for: ", heal_amount)
	emit_signal("health_changed", current_health)
	
	
#For Heal spell, send the spell the value of MPower which it then calculates the HP restore
#Then, return the calculated value back to the player which then passes it to the health component
