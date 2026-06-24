extends Item
class_name ConsumableItem

@export_enum("Health", "MP", "Full Restore") var restore_target: String = "Health"
@export var heal_amount: int = 0
@export var mp_restore_amount: int = 0
@export var effect_duration: float = 0.0  # For buffs like speed boost

func _init(p_name: String = "", p_description: String = "", p_icon: Texture2D = null, p_value: int = 0, p_type: String = "Consumable", p_max_stack: int = 99, p_heal_amount: int = 20, p_effect_duration: float = 0.0):
	super(p_name, p_description, p_icon, p_value, p_type, p_max_stack)
	heal_amount = p_heal_amount
	effect_duration = p_effect_duration

func use(player: Node) -> void:
	match restore_target:
		"Health":
			restore_health(player)
		"MP":
			restore_mp(player)
		"Full Restore":
			##TODO: Determine max health and mana to restore
			restore_health(player)
			restore_mp(player)

func restore_health(player: Node) -> void:
	if player.health_component.has_method("restore_health"):
		Heal.heal_power = heal_amount
		Heal.is_spell_heal = false
		player.health_component.restore_health(Heal)
	print(name, " used: Healed ", heal_amount, " HP")

func restore_mp(player: Node) -> void:
	if player.stats_component.has_method("restore_mp"):
		player.stats_component.restore_mp(mp_restore_amount)
		print(name, " used: Restored ", mp_restore_amount, " MP")
