extends Node2D
class_name DropComponent

@export var drop_chance: float = 0.95  # 0.0 to 1.0, chance to drop
@export var item_resource: Item  # The item to drop (your Resource)
@export var pickup_scene: PackedScene = preload("res://Resources/pickup.tscn")  # Your pickup scene

#const GOLD : Item = preload("res://Resources/gold.tres")
#not all block variables included
var can_move := true
var direction = Vector2(.5,.5)
@onready var velocity_component: VelocityComponent = $VelocityComponent

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func trigger_drop() -> void:
	var drop = rng.randf()
	if drop > drop_chance:
		print(drop)
		return
	print("DROP")
	var pickup = pickup_scene.instantiate()
	pickup.item_resource = load("res://Resources/gold.tres") #item_resource ##TODO learn why setting export as gold causes issues
	pickup.global_position = get_parent().global_position
	
	var enemy = get_parent()
	var inherited_velocity: Vector2 = Vector2(15.0,15.0)
	if enemy is CharacterBody2D && enemy.velocity != Vector2(0,0):
		inherited_velocity = enemy.velocity
	print(inherited_velocity)
	inherited_velocity = inherited_velocity.rotated( randf_range(-1.5, 1.5) ) * randf_range(10 , 20 )
	
	# Apply to pickup (assuming it has a 'velocity' property)
	if "velocity" in pickup:
		pickup.velocity = inherited_velocity
	
	# Add to the world (adjust to your main scene or a spawner node)
	get_tree().current_scene.add_child.call_deferred(pickup)
	
	#var pickup = load("res://Resources/pickup.tscn").instantiate()
	#pickup.item_resource = load("res://Resources/gold.tres")
	#get_tree().current_scene.add_child.call_deferred(pickup)
	#pickup.position = position
	#var velocity = Vector2(15.0,15.0)
	#pickup.velocity = velocity.rotated( randf_range(-1.5, 1.5) ) * randf_range(10 , 20 )
	#inherited_velocity += Vector2(rng.randf_range(-50, 50), rng.randf_range(-50, 50))
