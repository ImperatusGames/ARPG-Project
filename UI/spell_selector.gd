extends Control
class_name SpellUI

@onready var spell_list = $ItemList

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	spell_list.item_0.text = player.spell_manager.spell_array[0].spell_name
