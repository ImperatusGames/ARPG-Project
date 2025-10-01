extends Spell
class_name Cure_Spell

var heal_power : int
var magic_power: int

func _ready():
	healing()
	
func healing():
	if owner.has_node("HealthComponent"):
		var health_component = owner.get_node("HealthComponent")
		Heal.is_spell_heal = true
		Heal.spell_power = magic_power
		Heal.factor = 1.0
		health_component.heal(Heal)
