extends Area2D
class_name HurtBoxComponent

@export var health_component : HealthComponent

func _ready() -> void:
	#collision_layer = get_parent().collision_layer
	#collision_mask = get_parent().collision_mask
	pass

func damage(attack: Attack):
	if health_component:
		print("Attack Hit for: ", attack.attack_damage)
		health_component.damage(attack)
