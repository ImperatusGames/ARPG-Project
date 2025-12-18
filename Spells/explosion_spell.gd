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

func impact(area):
	if area is HurtBoxComponent:
		var hurtBox: HurtBoxComponent = area
		attack.attack_type = 1
		attack.magical_power = magical_power 
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)

func finished():
	has_finished.emit()
	queue_free()
