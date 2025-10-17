extends Node
class_name SpellManager

@export var spell_array : Array[Spell]
var current_spell : Spell

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var velocity_component : VelocityComponent = get_node("../VelocityComponent")

#Has an array of spell objects
#Each spell object has a flag for whether or not it is learned
#If it is learned then it becomes visible in the menu and can be selected and cast
#Each spell has a function within the SpellManager to handle code for calculating its effects

func _ready() -> void:
	current_spell = spell_array[0]

func cast_spell():
	print("Spell cast!")
	if current_spell == spell_array[0]:
		fireball(get_parent().last_direction)
	elif current_spell == spell_array[1]:
		heal_spell()

func fireball(last_direction: String):
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = get_parent().global_position
	new_fireball.global_rotation = get_parent().global_rotation
	new_fireball.current_direction = get_parent().last_direction
	new_fireball.magical_power = stats_component.current_magic
	
	#if player_direction == "up":
		#new_fireball.global_position.y -= 50
	#elif player_direction == "down":
		#new_fireball.global_position.y += 80
	#elif player_direction == "left":
		#new_fireball.global_position.x -= 60
	#elif player_direction == "right":
		#new_fireball.global_position.x += 60
	
	new_fireball.set_collision_mask_value(5, true)
	new_fireball.set_collision_layer_value(4, true)
	print("Fireball MPow", new_fireball.magical_power)
	add_sibling(new_fireball)
	
func heal_spell():
	const CURE_SPELL = preload("res://Spells/cure_spell.tscn")
	var new_cure_spell = CURE_SPELL.instantiate()
	new_cure_spell.magic_power = stats_component.current_magic
	add_sibling(new_cure_spell)
