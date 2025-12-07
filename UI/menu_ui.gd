extends Control

@onready var menu_items = $ItemList
@onready var description_text = $Description
@onready var spell_ui = preload("res://UI/spell_selector.tscn")


func _ready() -> void:
	menu_items.item_activated.connect(select_menu_item)
	menu_items.item_selected.connect(updated_description_text)

func _input(event):
	if event.is_action_pressed("menu"):
		print("close menu code")
		close_menu()

func select_menu_item(index):
	description_text.text = ""
	if menu_items.get_item_text(index) == "Items":
		print("Items selected!")
	elif menu_items.get_item_text(index) == "Equipment":
		print("Equipment selected!")
	elif menu_items.get_item_text(index) == "Spells":
		const SPELL_UI = preload("res://UI/spell_selector.tscn")
		var new_spell_ui = SPELL_UI.instantiate()
		add_child(new_spell_ui)
	elif menu_items.get_item_text(index) == "Status":
		print("Status selected!")
	elif menu_items.get_item_text(index) == "Settings":
		print("Settings selected!")
	else:
		print("Invalid item selected!")

func close_menu():
	print("Close menu func code")
	get_tree().paused = false
	hide()
	call_deferred("queue_free")

func updated_description_text(index):
	match index:
		0:
			description_text.text = "View the items in your inventory"
		1:
			description_text.text = "View and change your current equipment"
		2:
			description_text.text = "View and change your current spell"
		3:
			description_text.text = "Check your current status, stats, and more"
		4:
			description_text.text = "View and change your game settings"
