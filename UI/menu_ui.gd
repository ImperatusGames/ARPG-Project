extends Control

@onready var menu_items = $ItemList
@onready var description_text = $Description
@onready var spell_ui = preload("res://UI/spell_selector.tscn")
@onready var inventory_ui: InventoryUI = $InventoryUI

var player: Player = null

#TODO: Refactor Menu into a Pause_UI where all items are created in the same scene
#This allows all items to be shown/hidden appropriately without worrying about things being stacked on top of another
#To get an idea of what we want to avoid, open the menu, open Spells, and then select from the Menu again
#Yeah, doesn't look so hot, does it?

func _ready() -> void:
	menu_items.item_activated.connect(select_menu_item)
	menu_items.item_selected.connect(updated_description_text)
	
	initialize_inventory()
	
	# Connect inventory UI signals
	if inventory_ui:
		inventory_ui.inventory_closed.connect(_on_inventory_closed)

func initialize_inventory() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player and inventory_ui:
		inventory_ui.initialize(player)

func _input(event):
	if event.is_action_pressed("menu"):
		print("close menu code")
		close_menu()

func select_menu_item(index):
	description_text.text = ""
	if menu_items.get_item_text(index) == "Items":
		print("Items selected!")
		open_inventory()
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

func open_inventory() -> void:
	if inventory_ui:
		# Hide menu elements
		menu_items.hide()
		description_text.hide()
		
		# Show and open inventory
		inventory_ui.open_inventory()

func _on_inventory_closed() -> void:
	# Show menu elements again
	menu_items.show()
	description_text.show()

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
