extends Spell
class_name Explosion_Spell

var damage : int
var magical_power : int
var collider
var timer

func _ready() -> void:
	timer = $Timer
	area_entered.connect(impact)
	timer.timeout.connect(finished)
	collider = $CollisionShape2D
	print("Explosion Collision layer: ", collision_layer)
	print("Explosion Collision mask: ", collision_mask)
	if aug_state == true:
		set_scale(Vector2(1.25, 1.25))

func impact(area):
	if area is HurtBoxComponent:
		var hurtBox: HurtBoxComponent = area
		attack.damage_type = damage_type
		attack.element_type = element_type
		if aug_state == true:
			attack.magical_power = round(magical_power * 2.5)
		else:
			attack.magical_power = round(magical_power * 2)
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)

func finished():
	has_finished.emit()
	queue_free()
