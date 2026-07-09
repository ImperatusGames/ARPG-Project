extends StatusEffect
class_name StunnedStatus

func _ready() -> void:
	play("default")

func stun_ended():
	call_deferred("queue_free")
