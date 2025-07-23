extends AnimatedSprite2D

var collider

func _ready() -> void:
	animation_finished.connect(hide_sword)
	$Area2D.area_entered.connect(check_enemies)
	play("swing")
	#collider = $Area2D

func _process(_delta: float) -> void:
	pass

func hide_sword():
	print("Attack finished")
	call_deferred("queue_free")

func check_enemies(area):
	if area is HurtBoxComponent:
		print("Hurt Box detected!")
