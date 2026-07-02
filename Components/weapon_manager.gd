extends Node
class_name WeaponManager

signal weapon_changed(new_weapon)
signal attack_finished

@export var weapon_array : Array[Weapon]

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var velocity_component : VelocityComponent = get_node("../VelocityComponent")

var last_direction : String
var current_weapon : Weapon

func _ready() -> void:
	current_weapon = weapon_array[0]

func weapon_attack():
	match current_weapon.weapon_name:
		"Sword":
			sword_attack()
		"Axe":
			axe_attack()

#TODO: Fix weapons
# They are completely broken because they are not on layers right now
# However layers are handled differently for weapons than spells because they are AnimatedSprite2Ds instead of Area2Ds

func sword_attack():
	const SWORD = preload("res://Weapons/sword.tscn")
	var new_sword = SWORD.instantiate()
	new_sword.physical_power = stats_component.current_strength
	new_sword.set_collision_mask_value(5, true)
	new_sword.set_collision_layer_value(2, true)
	if last_direction == "right":
		new_sword.global_position.x += 60
	elif last_direction == "left":
		new_sword.rotation_degrees = 180
		new_sword.global_position.x -= 60
	elif last_direction == "up":
		new_sword.global_position.y -= 60
		new_sword.rotation_degrees = -90
	elif last_direction == "down":
		new_sword.global_position.y += 75
		new_sword.rotation_degrees = 90
	add_sibling(new_sword)
	await new_sword.animation.animation_finished
	emit_signal("attack_finished")

func axe_attack():
	const AXE = preload("res://Weapons/axe.tscn")
	var new_axe = AXE.instantiate()
	new_axe.physical_power = stats_component.current_strength
	new_axe.set_collision_mask_value(5, true)
	new_axe.set_collision_layer_value(2, true)
	if last_direction == "right":
		new_axe.global_position.x += 60
	elif last_direction == "left":
		new_axe.rotation_degrees = 180
		new_axe.global_position.x -= 60
	elif last_direction == "up":
		new_axe.global_position.y -= 60
		new_axe.rotation_degrees = -90
	elif last_direction == "down":
		new_axe.global_position.y += 75
		new_axe.rotation_degrees = 90
	add_sibling(new_axe)
	await new_axe.animation.animation_finished
	emit_signal("attack_finished")

func set_weapon(index):
	current_weapon = weapon_array[index]
	weapon_changed.emit(current_weapon)
