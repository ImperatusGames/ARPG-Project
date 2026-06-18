extends Control
class_name StatusUI

signal status_menu_closed

@onready var close_button: Button = $Panel/MarginContainer/VBoxContainer/Button

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
	close_button.pressed.connect(close)

func close():
	hide()
	emit_signal("status_menu_closed")
