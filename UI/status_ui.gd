extends Control
class_name StatusUI

signal status_menu_closed

@onready var close_button: Button = $Panel/MarginContainer/VBoxContainer/Button

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
	close_button.pressed.connect(_on_close_pressed)
	
	grab_focus()

#func close():
	#hide()
	#emit_signal("status_menu_closed")

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_on_close_pressed()
		accept_event()

func _on_close_pressed() -> void:
	hide()
	emit_signal("status_menu_closed")
	
