extends Weapon
class_name Sword_Weapon

var collider
var damage: int
var physical_power: int

func _ready() -> void:
	animation_finished.connect(hide_sword)
	$Area2D.area_entered.connect(check_enemies)
	collider = $Area2D/CollisionShape2D
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
		var hurtBox: HurtBoxComponent = area
		attack.weapon_type = weapon_type
		attack.damage_type = damage_type
		attack.physical_power = physical_power #TODO: Need to modify to be based on the caster's Strength stat
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)
