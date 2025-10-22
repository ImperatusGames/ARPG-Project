extends AnimatedSprite2D
class_name Weapon

signal has_finished

func finished():
	queue_free()
