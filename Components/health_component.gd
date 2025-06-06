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
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		emit_signal("health_empty")
		
func heal():
	current_health = max_health
	emit_signal("health_changed", current_health)
