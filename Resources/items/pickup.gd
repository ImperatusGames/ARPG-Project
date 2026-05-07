extends CharacterBody2D

@export var item_resource: Item = null

@onready var area_2d: Area2D = $Area2D

func _ready():
	$Sprite2D.texture = item_resource.icon
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide( velocity * delta )
	if collision_info:
		velocity = velocity.bounce( collision_info.get_normal() )
	velocity -= velocity * delta * 4	

func _on_area_2d_body_entered(body):
	if not body is Player:
		return

	if item_resource == null:
		print("Pickup has no item_resource")
		return

	if body.add_item_to_inventory(item_resource, 1):
		queue_free()
	else:
		print("Inventory full, pickup stays in world")
