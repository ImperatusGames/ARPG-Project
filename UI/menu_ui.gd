extends Control

@onready var menu_items = $ItemList

func _ready() -> void:
	menu_items.item_activated.connect("select_menu_item")

func select_menu_item(index):
	if index.text == "Items":
		pass
	elif index.text == "Equipment":
		pass
	elif index.text == "Spells":
		print("SpellSelector selection!")
	elif index.text == "Status":
		pass
	else:
		print("Invalid item selected!")
