extends Node2D
class_name DamageComponent

@export var BASE_DAMAGE_RATE : float
@export var current_damage_rate: float

func _ready() -> void:
	current_damage_rate = BASE_DAMAGE_RATE
