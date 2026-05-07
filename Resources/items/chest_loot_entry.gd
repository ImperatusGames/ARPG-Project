extends Resource
class_name ChestLootEntry

@export var item: Item
@export_range(1, 999, 1) var max_quantity: int = 1
