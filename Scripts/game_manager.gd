extends Node

signal game_pause
signal game_unpause

@onready var game_ui = preload("res://UI/game_ui.tscn")
@onready var menu_ui = preload("res://UI/menu_ui.tscn")

var menu_active := false

#func menu_button_pressed():
	#pass

func _input(event):
	if event.is_action_pressed("menu"):
		if menu_active == false:
			const MENU_UI = preload("res://UI/menu_ui.tscn")
			var new_menu_ui = MENU_UI.instantiate()
			add_child(new_menu_ui)
			menu_active = true
			game_pause.emit()
			get_tree().paused = true
			print("Menu button pressed!")
		else:
			game_unpause.emit()
			menu_active = false
