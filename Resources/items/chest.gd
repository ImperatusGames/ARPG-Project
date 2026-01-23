extends Node2D

@export var item_data: Item
@export var quantity: int = 1

var is_open : bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_stack_label: Label = $ItemSprite/ItemStack
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area_2d: Area2D = $Area2D

func _ready() -> void:
	interact_area_2d.body_entered.connect(_on_body_entered) 
	interact_area_2d.body_exited.connect(_on_body_exited)

#Player enters chest area
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body._on_chest_body_entered(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body._on_chest_body_exited(self)

func open() -> bool:
	if is_open:
		print("Chest already opened")
		return false
	
	if item_data == null:
		print("Chest is empty")
		return false
	
	#Try to add item to player inventory
	#use self?
	var player = get_tree().get_first_node_in_group("Player")
	if player.add_item_to_inventory(item_data, quantity):
		is_open = true
		animation_player.play("open") 
		print("Chest opened! Received: ", item_data.name, " x", quantity)
		return true
	else:
		print("Inventory full! Cannot open chest.")
		return false
	# Add item to inventory here with signal/anim finished?
	#return true
