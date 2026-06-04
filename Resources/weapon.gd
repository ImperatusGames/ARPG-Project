extends AnimatedSprite2D
class_name Weapon

@export var weapon_name : String
@export var weapon_type : Globals.WEAPON_TYPES
@export var elemental_type : Globals.ELEMENT_TYPES
var damage_type = Globals.DAMAGE_TYPES.PHYSICAL

signal has_finished

func finished():
	queue_free()
