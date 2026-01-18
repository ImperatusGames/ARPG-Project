extends Node2D
class_name InventoryManager

signal inventory_updated
signal item_added(item: Item, quantity: int)
signal item_removed(item: Item, quantity: int)

@export var max_slots: int = 20

var item_array : Array[Item]
var equipment_array : Array[Equipment]
var weapon_array : Array[Weapon]
var currency := 0

var inventory: Array[Dictionary] = []

func _ready() -> void:
	for i in range(max_slots):
		inventory.append({})

func add_item(item: Item, quantity: int = 1) -> bool:
	if item == null:
		print("null item")
		return false
	
	
	if !has_space_for(item, quantity):
		print("Inventory full!")
		return false
	
	var remaining_quantity = quantity
	#fill existing stack
	if item.max_stack > 1:
		for slot in inventory:
			if slot.has("item") and slot["item"] == item:
				var available_space = item.max_stack - slot["quantity"]
				if available_space > 0:
					var amount_to_add = min(available_space, remaining_quantity)
					slot["quantity"] += amount_to_add
					remaining_quantity -= amount_to_add
					
					if remaining_quantity <= 0:
						emit_signal("item_added", item, quantity)
						emit_signal("inventory_updated")
						return true
	#add to empty slots
	while remaining_quantity > 0:
		var empty_slot_index = find_empty_slot()
		#TODO: Fill inventory with what's possible?
		if empty_slot_index == -1:
			print("Inventory full! Added ", (quantity - remaining_quantity),  " items.")
			if remaining_quantity < quantity:
				# Partial success
				emit_signal("item_added", item, quantity - remaining_quantity)
				emit_signal("inventory_updated")
			return false
		
		var amount_to_add = min(item.max_stack, remaining_quantity)
		inventory[empty_slot_index] = {
			"item": item,
			"quantity": amount_to_add
		}
		remaining_quantity -= amount_to_add
	
	print("Inventory: ", inventory ) 
	emit_signal("item_added", item, quantity)
	emit_signal("inventory_updated")
	return true

func remove_item(item: Item, quantity: int = 1) -> bool:
	var remaining_quantity = quantity
	
	for i in range(inventory.size() - 1, -1, -1):
		var slot = inventory[i]
		if slot.has("item") and slot["item"] == item:
			var amount_to_remove = min(slot["quantity"], remaining_quantity)
			slot["quantity"] -= amount_to_remove
			remaining_quantity -= amount_to_remove
			
			if slot["quantity"] <= 0:
				inventory[i] = {}
			
			if remaining_quantity <= 0:
				emit_signal("item_removed", item, quantity)
				emit_signal("inventory_updated")
				return true
	
	if remaining_quantity < quantity:
		# partial removal?
		emit_signal("item_removed", item, quantity - remaining_quantity)
		emit_signal("inventory_updated")
	
	return remaining_quantity == 0

# Find first empty slot
func find_empty_slot() -> int:
	for i in range(inventory.size()):
		if inventory[i].is_empty():
			return i
	return -1

# Get quantity of specific item
func get_item_count(item: Item) -> int:
	var count = 0
	for slot in inventory:
		if slot.has("item") and slot["item"] == item:
			count += slot["quantity"]
	return count

# Get item at specific slot
func get_item_at_slot(slot_index: int) -> Dictionary:
	if slot_index >= 0 and slot_index < inventory.size():
		return inventory[slot_index]
	return {}

# Check if inventory contains item
func has_item(item: Item, quantity: int = 1) -> bool:
	return get_item_count(item) >= quantity

# Get all items in inventory
func get_all_items() -> Array[Dictionary]:
	var items: Array[Dictionary] = []
	for slot in inventory:
		if slot.has("item"):
			items.append(slot)
	return items

# Clear entire inventory
func clear_inventory() -> void:
	for i in range(inventory.size()):
		inventory[i] = {}
	emit_signal("inventory_updated")

# Check if inventory has space for item
func has_space_for(item: Item, quantity: int = 1) -> bool:
	var remaining_quantity = quantity
	
	# Check existing stacks
	if item.max_stack > 1:
		for slot in inventory:
			if slot.has("item") and slot["item"] == item:
				var available_space = item.max_stack - slot["quantity"]
				remaining_quantity -= available_space
				if remaining_quantity <= 0:
					return true
	
	# Check empty slots
	var empty_slots = 0
	for slot in inventory:
		if slot.is_empty():
			empty_slots += 1
	
	var slots_needed = ceili(float(remaining_quantity) / float(item.max_stack))
	return empty_slots >= slots_needed
