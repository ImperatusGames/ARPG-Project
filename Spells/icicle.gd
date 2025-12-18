extends Spell
class_name Icicle_Spell

var travelled_distance := 0.0
var damage : int
var magical_power : int
var current_direction : String
var collider
var direction

func _ready() -> void:
	area_entered.connect(impact)
	has_finished.connect(finished)
	collider = %CollisionShape2D
	print("Icicle Collision layer: ", collision_layer)
	print("Icicle Collision mask: ", collision_mask)

func _physics_process(delta: float) -> void:
	const SPEED = 350
	const RANGE = 1200
	
	if current_direction.to_lower() == "up":
		direction = Vector2.UP.rotated(rotation)
	elif current_direction.to_lower() == "down":
		direction = Vector2.DOWN.rotated(rotation)
	elif current_direction.to_lower() == "right":
		direction = Vector2.RIGHT.rotated(rotation)
	elif current_direction.to_lower() == "left":
		direction = Vector2.LEFT.rotated(rotation)
	else:
		direction = Vector2.RIGHT.rotated(rotation)
	
	#Create enum for Up/Down/Left/Right to ignore casing - will be used for other spells
	position += direction * SPEED * delta
		
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		print("Icicle out of bounds!")
		has_finished.emit()

func impact(area):
	if area is HurtBoxComponent:
		var hurtBox: HurtBoxComponent = area
		attack.attack_type = 1
		attack.magical_power = magical_power
		#attack.status
		#TODO Part 2: Create formula for spell damage
		hurtBox.new_damage(attack)
	
		#TODO: Add Frozen status effect
		#Does the Frozen status end after a timer or only after a hit is received?
		#Since the Frozen status assists with puzzles it may make more sense to not have a timer tied to it
		#Frozen enemies would not provide XP as they aren't defeated, though
	
	has_finished.emit()
