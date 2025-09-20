extends Spell
class_name Cure_Spell

signal heal_spell

var heal_power : int
var magic_power: int

func _ready():
	heal_spell.connect(_healing)
	emit_signal("heal_spell")

func _healing():
	return magic_power * heal_power
