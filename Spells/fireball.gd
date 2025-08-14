extends Spell
class_name Fireball_Spell

var travelled_distance := 0.0
var player_direction : String
var collider
var direction

func _ready() -> void:
	area_entered.connect(impact)
	collider = %CollisionShape2D
	print("Fireball Collision layer: ", collision_layer)
	print("Fireball Collision mask: ", collision_mask)

func _physics_process(delta: float) -> void:
	const SPEED = 600
	const RANGE = 1200
	
	if player_direction.to_lower() == "up":
		direction = Vector2.UP.rotated(rotation)
	elif player_direction.to_lower() == "down":
		direction = Vector2.DOWN.rotated(rotation)
	elif player_direction.to_lower() == "right":
		direction = Vector2.RIGHT.rotated(rotation)
	elif player_direction.to_lower() == "left":
		direction = Vector2.LEFT.rotated(rotation)
	else:
		direction = Vector2.RIGHT.rotated(rotation)
	
	#Create enum for Up/Down/Left/Right to ignore casing - will be used for other spells
	#print(direction)
	position += direction * SPEED * delta
		
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		print("Fireball out of bounds!")
		queue_free()

func impact(area):
	if area is HurtBoxComponent:
		var hurtBox: HurtBoxComponent = area
		attack.attack_damage = 5 #TODO: Need to modify to be based on the caster's Magic Power stat
		#TODO Part 2: Create formula for spell damage
		hurtBox.damage(attack)
	
	queue_free()

	
