extends Item
class_name ConsumableItem

@export var heal_amount: int = 20
@export var effect_duration: float = 0.0  # For buffs like speed boost

func _init(p_name: String = "", p_description: String = "", p_icon: Texture2D = null, p_value: int = 0, p_type: String = "Consumable", p_max_stack: int = 99, p_heal_amount: int = 20, p_effect_duration: float = 0.0):
	super(p_name, p_description, p_icon, p_value, p_type, p_max_stack)
	heal_amount = p_heal_amount
	effect_duration = p_effect_duration

func use(player: Node) -> void:
	if player.has_method("heal"):
		player.heal(heal_amount)
	print(name, " used: Healed ", heal_amount, " HP")
