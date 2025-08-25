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
	print("Attack type: ", attack.attack_type)
	if stats_component:
		if attack.attack_type == 0:
			var calculated_damage = attack.physical_power - stats_component.current_defense
			health_component.new_damage(calculated_damage)
			print(attack.physical_power)
		elif attack.attack_type == 1:
			var calculated_damage = attack.magical_power - stats_component.current_magic_def
			health_component.new_damage(calculated_damage)
			print(attack.magical_power)
		else:
			print("No type trigger")
