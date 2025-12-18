extends Control
class_name SpellUI

@onready var spell_list = $ItemList
@onready var spell_description = $SpellDescription

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	spell_list.set_item_text(0, player.spell_manager.spell_array[0].spell_name)
	spell_list.set_item_text(1, player.spell_manager.spell_array[1].spell_name)
	spell_list.set_item_text(2, player.spell_manager.spell_array[2].spell_name)
	spell_list.set_item_text(3, player.spell_manager.spell_array[3].spell_name)
	spell_list.set_item_text(4, player.spell_manager.spell_array[4].spell_name)
	spell_list.item_activated.connect(new_current_spell)
	spell_list.item_selected.connect(update_spell_description)

func new_current_spell(index):
	player.spell_manager.set_spell(index)
	print(spell_list.get_item_text(index))
	queue_free()

func update_spell_description(index):
	spell_description.text = player.spell_manager.spell_array[index].spell_description
