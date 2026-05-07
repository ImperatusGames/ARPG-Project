extends Node2D
class_name DropComponent

@export var drop_chance: float = 0.95  # 0.0 to 1.0, chance to drop
@export var chest_scene: PackedScene = preload("res://Resources/items/chest.tscn")
@export var loot_table: Array[ChestLootEntry] = []
@export var fallback_item: Item
@export_range(1, 999, 1) var fallback_max_quantity: int = 1

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func trigger_drop() -> void:
	var drop = rng.randf()
	if drop > drop_chance:
		print(drop)
		return
	print("DROP CHEST")

	if chest_scene == null:
		print("No chest scene configured for drop component")
		return

	var loot = roll_loot()
	if loot.is_empty():
		print("No loot configured for drop component")
		return

	var chest = chest_scene.instantiate()
	chest.item_data = loot["item"]
	chest.quantity = loot["quantity"]
	chest.global_position = get_parent().global_position
	get_tree().current_scene.add_child.call_deferred(chest)

func roll_loot() -> Dictionary:
	var valid_entries: Array[ChestLootEntry] = []

	for entry in loot_table:
		if entry != null and entry.item != null and entry.max_quantity > 0:
			valid_entries.append(entry)

	if valid_entries.is_empty():
		if fallback_item == null or fallback_max_quantity <= 0:
			return {}
		return {
			"item": fallback_item,
			"quantity": roll_quantity(fallback_max_quantity)
		}

	var entry_index := rng.randi_range(0, valid_entries.size() - 1)
	var selected_entry := valid_entries[entry_index]
	return {
		"item": selected_entry.item,
		"quantity": roll_quantity(selected_entry.max_quantity)
	}

func roll_quantity(max_quantity: int) -> int:
	if max_quantity <= 1:
		return 1

	var total_weight := 0
	for amount in range(1, max_quantity + 1):
		total_weight += (max_quantity - amount + 1)

	var roll := rng.randi_range(1, total_weight)
	var running_total := 0

	for amount in range(1, max_quantity + 1):
		running_total += (max_quantity - amount + 1)
		if roll <= running_total:
			return amount

	return 1
