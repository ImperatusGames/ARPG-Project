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

func use(player: Node) -> bool:
	if not can_use(player):
		print(name, " had no effect")
		return false

	match restore_target:
		"Health":
			restore_health(player)
		"MP":
			restore_mp(player)
		"Full Restore":
			##TODO: Determine max health and mana to restore
			restore_health(player)
			restore_mp(player)
	return true

func can_use(player: Node) -> bool:
	if player == null:
		return false

	match restore_target:
		"Health":
			return heal_amount > 0 and player.health_component.current_health < player.health_component.max_health
		"MP":
			return mp_restore_amount > 0 and player.stats_component.current_mp < player.stats_component.max_mp
		"Full Restore":
			var can_restore_health = heal_amount > 0 and player.health_component.current_health < player.health_component.max_health
			var can_restore_mp = mp_restore_amount > 0 and player.stats_component.current_mp < player.stats_component.max_mp
			return can_restore_health or can_restore_mp

	return false

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
