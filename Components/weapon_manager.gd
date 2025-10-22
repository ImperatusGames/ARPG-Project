extends Node
class_name WeaponManager

@export var weapon_array : Array[Weapon]
var current_weapon : Weapon

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var velocity_component : VelocityComponent = get_node("../VelocityComponent")
var last_direction : String

func _ready() -> void:
	current_weapon = weapon_array[0]

func weapon_attack():
	if current_weapon == weapon_array[0]:
		sword_attack()

func sword_attack():
	const SWORD = preload("res://Weapons/sword.tscn")
	var new_sword = SWORD.instantiate()
	new_sword.physical_power = stats_component.current_strength
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
	await new_sword.animation_finished
