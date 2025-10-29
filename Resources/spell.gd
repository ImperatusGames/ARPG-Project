extends Area2D
class_name Spell

signal has_finished

@export var mp_cost : int
@export var is_known := false
@export var spell_name : String

func _ready() -> void:
	has_finished.connect(finished)

func finished():
	queue_free()
