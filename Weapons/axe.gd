extends Weapon
class_name Axe_Weapon

var collider
var damage: int
var physical_power: int

func _ready() -> void:
	animation_finished.connect(hide_axe)
	$Area2D.area_entered.connect(check_enemies)
	play("swing")
	#collider = $Area2D

func _process(_delta: float) -> void:
	pass

func hide_axe():
	print("Attack finished")
	call_deferred("queue_free")

func check_enemies(area):
	if area is HurtBoxComponent:
		print("Hurt Box detected!")
		var hurtBox: HurtBoxComponent = area
		attack.attack_type = 0
		attack.physical_power = physical_power #TODO: Need to modify to be based on the caster's Strength stat
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)
