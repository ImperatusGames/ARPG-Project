extends Control
class_name InventoryUI

signal item_selected(item: Item, quantity: int)
signal inventory_closed

@onready var inventory_grid: GridContainer = $Panel/MarginContainer/VBoxContainer/InventoryGrid
@onready var item_name_label: Label = $Panel/MarginContainer/VBoxContainer/ItemDetails/ItemName
@onready var item_description_label: Label = $Panel/MarginContainer/VBoxContainer/ItemDetails/ItemDescription
@onready var item_value_label: Label = $Panel/MarginContainer/VBoxContainer/ItemDetails/ItemValue
@onready var item_icon: TextureRect = $Panel/MarginContainer/VBoxContainer/ItemDetails/ItemIcon
@onready var use_button: Button = $Panel/MarginContainer/VBoxContainer/ItemDetails/UseButton
@onready var close_button: Button = $Panel/MarginContainer/VBoxContainer/CloseButton

var inventory_manager: InventoryManager
var player: Player
var inventory_slots: Array[InventorySlot] = []
var selected_slot: InventorySlot = null

# Preload the inventory slot scene
const INVENTORY_SLOT_SCENE = preload("res://UI/inventory/inventory_slot.tscn")

func _ready() -> void:
	hide()
	
	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	
	if use_button:
		use_button.pressed.connect(_on_use_pressed)
		use_button.disabled = true

func initialize(p_player: Player) -> void:
	player = p_player
	if player and player.has_node("InventoryManager"):
		inventory_manager = player.get_node("InventoryManager")
		inventory_manager.inventory_updated.connect(_on_inventory_updated)
		setup_inventory_grid()
		refresh_inventory()

func setup_inventory_grid() -> void:
	if not inventory_grid or not inventory_manager:
		return
	
	# Clear existing slots
	for slot in inventory_slots:
		slot.queue_free()
	inventory_slots.clear()
	
	# Create inventory slots
	for i in range(inventory_manager.max_slots):
		var slot: InventorySlot
		
		# If you have a preloaded scene, use it, otherwise create programmatically
		if INVENTORY_SLOT_SCENE:
			slot = INVENTORY_SLOT_SCENE.instantiate()
		else:
			slot = create_slots()
		
		slot.slot_index = i
		slot.slot_clicked.connect(_on_slot_clicked)
		inventory_grid.add_child(slot)
		inventory_slots.append(slot)

func create_slots() -> InventorySlot:
	var slot = InventorySlot.new()
	#slot.custom_minimum_size = Vector2(64, 64)
	return slot

func refresh_inventory() -> void:
	if not inventory_manager:
		return
	
	for i in range(inventory_slots.size()):
		var slot_data = inventory_manager.get_item_at_slot(i)
		inventory_slots[i].set_item(slot_data)

func _on_inventory_updated() -> void:
	refresh_inventory()

func _on_slot_clicked(slot: InventorySlot) -> void:
	# Deselect previous slot
	if selected_slot:
		selected_slot.set_selected(false)
	
	selected_slot = slot
	slot.set_selected(true)
	
	# Update item details
	var slot_data = inventory_manager.get_item_at_slot(slot.slot_index)
	if slot_data.has("item"):
		show_item_details(slot_data["item"], slot_data["quantity"])
	else:
		clear_item_details()

func show_item_details(item: Item, quantity: int) -> void:
	if item_name_label:
		item_name_label.text = item.name
	
	if item_description_label:
		item_description_label.text = item.description
	
	if item_value_label:
		item_value_label.text = "Value: " + str(item.value) + " gold | Quantity: " + str(quantity)
	
	if item_icon and item.icon:
		item_icon.texture = item.icon
		item_icon.show()
	else:
		if item_icon:
			item_icon.hide()
	
	if use_button:
		# Enable use button only for consumables
		use_button.disabled = not (item.type == "Consumable") ##item is "Consumable" or 

func clear_item_details() -> void:
	if item_name_label:
		item_name_label.text = "No Item Selected"
	
	if item_description_label:
		item_description_label.text = ""
	
	if item_value_label:
		item_value_label.text = ""
	
	if item_icon:
		item_icon.hide()
	
	if use_button:
		use_button.disabled = true

func _on_use_pressed() -> void:
	if not selected_slot or not player:
		return
	
	var slot_data = inventory_manager.get_item_at_slot(selected_slot.slot_index)
	if slot_data.has("item"):
		var item = slot_data["item"]
		
		# Use the item
		item.use(player)
		
		# Remove one from inventory
		inventory_manager.remove_item(item, 1)
		
		# Emit signal
		emit_signal("item_selected", item, 1)
		
		# Clear selection if no more of this item
		var remaining = inventory_manager.get_item_at_slot(selected_slot.slot_index)
		if remaining.is_empty():
			clear_item_details()
			selected_slot.set_selected(false)
			selected_slot = null

func _on_close_pressed() -> void:
	hide()
	emit_signal("inventory_closed")
	
	# Unpause game if needed
	#get_tree().paused = false

func open_inventory() -> void:
	show()
	refresh_inventory()
	
	# Pause game when inventory is open
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_on_close_pressed()
		accept_event()
