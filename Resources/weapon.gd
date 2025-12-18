extends AnimatedSprite2D
class_name Weapon

@export var weapon_name : String

signal has_finished

func finished():
	queue_free()
