extends Entity
class_name Zombie

var health := 1

func _ready() -> void:
	var hurtbox = $HurtBoxComponent
	print("Hurtbox Collision Layer: ", hurtbox.collision_layer)
	print("Hurtbox Collision Mask: ", hurtbox.collision_mask)
