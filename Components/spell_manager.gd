extends Node
class_name SpellManager

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var velocity_component : VelocityComponent = get_node("../VelocityComponent")

signal spell_changed(current_spell)

@export var spell_array : Array[Spell]
var current_spell : Spell
var last_direction : String

#Has an array of spell objects
#Each spell object has a flag for whether or not it is learned
#If it is learned then it becomes visible in the menu and can be selected and cast
#Each spell has a function within the SpellManager to handle code for calculating its effects

func _ready() -> void:
	current_spell = spell_array[0]

func cast_spell():
	print("Spell cast!")
	if current_spell == null:
		print("No spell selected!")
	else:
		if check_mp() == true:
			deduct_mp()
			match current_spell.spell_name:
				"Fireball":
					fireball()
				"Cure":
					heal_spell()
				"Defender":
					defender_spell()
				"Icicle":
					icicle()
				"Explosion":
					explosion_spell()
		else:
			print("Not enough MP!")
			print("Current MP: ", stats_component.current_mp)
			print("Spell Cost: ", current_spell.mp_cost)

func fireball():
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = get_parent().global_position
	new_fireball.global_rotation = get_parent().global_rotation
	new_fireball.current_direction = last_direction
	new_fireball.magical_power = stats_component.current_magic
	new_fireball.set_collision_mask_value(5, true)
	new_fireball.set_collision_layer_value(4, true)
	#Need to adjust mask and layer based on the entity that spawns the object
	#Player will have one set of values, Enemy will have a different set
	print("Fireball MPow: ", new_fireball.magical_power)
	add_sibling(new_fireball)

func icicle():
	const ICICLE = preload("res://Spells/icicle.tscn")
	var new_icicle = ICICLE.instantiate()
	new_icicle.global_position = get_parent().global_position
	new_icicle.global_rotation = get_parent().global_rotation
	new_icicle.current_direction = last_direction
	new_icicle.magical_power = stats_component.current_magic
	new_icicle.set_collision_mask_value(5, true)
	new_icicle.set_collision_layer_value(4, true)
	#Need to adjust mask and layer based on the entity that spawns the object
	#Player will have one set of values, Enemy will have a different set
	print("Icicle MPow: ", new_icicle.magical_power)
	add_sibling(new_icicle)

func explosion_spell():
	const EXPLOSION = preload("res://Spells/explosion_spell.tscn")
	var new_explosion = EXPLOSION.instantiate()
	new_explosion.global_position = get_parent().global_position
	new_explosion.global_rotation = get_parent().global_rotation
	new_explosion.magical_power = stats_component.current_magic
	new_explosion.set_collision_mask_value(5, true)
	new_explosion.set_collision_layer_value(4, true)
	#Need to adjust mask and layer based on the entity that spawns the object
	#Player will have one set of values, Enemy will have a different set
	print("Explsion MPow: ", new_explosion.magical_power)
	add_sibling(new_explosion)

func heal_spell():
	const CURE_SPELL = preload("res://Spells/cure_spell.tscn")
	var new_cure_spell = CURE_SPELL.instantiate()
	new_cure_spell.magic_power = stats_component.current_magic
	#print("Heal Spell Power: ", new_cure_spell.magic_power)
	add_sibling(new_cure_spell)

func defender_spell():
	if get_parent().has_node("Defender Spell"):
		var defender = get_parent().get_node("Defender Spell")
		defender.spell_cast()
	else:
		const DEFENDER_SPELL = preload("res://Spells/defender_spell.tscn")
		var new_defender_spell = DEFENDER_SPELL.instantiate()
		new_defender_spell.stats_component = stats_component
		add_sibling(new_defender_spell)
		new_defender_spell.spell_cast()

func check_mp():
	if current_spell.mp_cost > stats_component.current_mp:
		return false
	else:
		return true
		#Create error failover for lack of MP

func deduct_mp():
	stats_component.current_mp -= current_spell.mp_cost
	stats_component.spell_cast()
	print("Spent MP: ", current_spell.mp_cost)

func set_spell(index):
	current_spell = spell_array[index]
	spell_changed.emit(current_spell)
