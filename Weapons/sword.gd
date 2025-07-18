extends AnimatedSprite2D

func _ready() -> void:
	animation_finished.connect(hide_sword)
	play("swing")
	
func hide_sword():
	print("Attack finished")
	call_deferred("queue_free")
