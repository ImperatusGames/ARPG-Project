extends Control
class_name SpellUI

signal spell_menu_closed

@onready var spell_list = $ItemList
@onready var spell_description = $SpellDescription
@onready var close_button = $Button

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	for i in range(0, player.spell_manager.spell_array.size()):
		if player.spell_manager.spell_array[i].is_known == true:
			spell_list.set_item_text(i, player.spell_manager.spell_array[i].spell_name)
			spell_list.set_item_selectable(i, true)
			spell_list.set_item_disabled(i, false)
	spell_list.item_activated.connect(new_current_spell)
	spell_list.item_selected.connect(update_spell_description)
	close_button.pressed.connect(close)

func new_current_spell(index):
	player.spell_manager.set_spell(index)
	print(spell_list.get_item_text(index))
	close()

func update_spell_description(index):
	spell_description.text = player.spell_manager.spell_array[index].spell_description

func close():
	hide()
	emit_signal("spell_menu_closed")
