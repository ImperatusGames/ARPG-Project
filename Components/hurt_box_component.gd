extends Area2D
class_name HurtBoxComponent

@export var health_component : HealthComponent
@export var stats_component : StatsComponent

func _ready() -> void:
	#collision_layer = get_parent().collision_layer
	#collision_mask = get_parent().collision_mask
	pass

func damage(attack: Attack):
	if health_component:
		print("Attack Hit for: ", attack.attack_damage)
		health_component.damage(attack)

func new_damage(attack: Attack):
	if stats_component:
		var calculated_damage = attack.attack_damage - stats_component.current_defense
		health_component.damage(calculated_damage)
