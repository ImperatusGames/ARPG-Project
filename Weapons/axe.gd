extends Weapon
class_name Axe_Weapon

func _ready() -> void:
	animation = $AnimatedSprite2D
	#collider = $CollisionShape2D
	animation.animation_finished.connect(hide_axe)
	area_entered.connect(check_enemies)
	animation.play("swing")
	
func _process(_delta: float) -> void:
	pass

func hide_axe():
	print("Attack finished")
	#emit_signal("has_finished")
	call_deferred("queue_free")

func check_enemies(area):
	if area is HurtBoxComponent:
		print("Hurt Box detected!")
		var hurtBox: HurtBoxComponent = area
		attack.damage_type = damage_type
		attack.weapon_type = weapon_type
		attack.physical_power = physical_power #TODO: Need to modify to be based on the caster's Strength stat
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)
