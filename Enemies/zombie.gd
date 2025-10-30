extends Entity
class_name Zombie

#var health := 1

func _ready() -> void:
	var hurtbox = $HurtBoxComponent
	print("Hurtbox Collision Layer: ", hurtbox.collision_layer)
	print("Hurtbox Collision Mask: ", hurtbox.collision_mask)
	$HealthComponent.health_depleted.connect(_on_health_depleted)

func _on_health_depleted():
	print("Dead unit")
	$DropComponent.trigger_drop()
	call_deferred("queue_free")
