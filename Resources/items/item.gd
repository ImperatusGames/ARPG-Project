extends Resource
class_name Item

#Base Class for any item that is placed into the player's inventory
@export var name: String = ""
@export var description: String = ""
@export var icon: Texture2D = null
@export var value: int = 0
@export_enum("Weapon", "Consumable", "Armor", "Misc") var type: String = "Misc"
@export var max_stack: int = 1

func _init(p_name: String = "", p_description: String = "", p_icon: Texture2D = null, p_value: int = 0, p_type: String = "", p_max_stack: int = 1):
	name = p_name
	description = p_description
	icon = p_icon
	value = p_value
	type = p_type
	max_stack = p_max_stack

# Virtual method for subclass overriding
func use(_player: Node) -> void:
	print("Using base item: ", name)
