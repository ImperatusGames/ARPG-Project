extends Control

@onready var menu_items = $ItemList
@onready var spell_ui = preload("res://UI/spell_selector.tscn")


func _ready() -> void:
	menu_items.item_activated.connect(select_menu_item)

func _input(event):
	if event.is_action_pressed("menu"):
		print("close menu code")
		close_menu()

func select_menu_item(index):
	if menu_items.get_item_text(index) == "Items":
		pass
	elif menu_items.get_item_text(index) == "Equipment":
		pass
	elif menu_items.get_item_text(index) == "Spells":
		const SPELL_UI = preload("res://UI/spell_selector.tscn")
		var new_spell_ui = SPELL_UI.instantiate()
		add_child(new_spell_ui)
	elif menu_items.get_item_text(index) == "Status":
		pass
	else:
		print("Invalid item selected!")

func close_menu():
	print("Close menu func code")
	get_tree().paused = false
	hide()
	call_deferred("queue_free")
