extends CanvasLayer
class_name GameUI

@onready var health_bar: ProgressBar = $HealthBar/HPBar
@onready var health_label: Label = $HealthBar/HPBar/Label
@onready var mp_bar: ProgressBar = $ManaBar/MPBar
@onready var mp_label: Label = $ManaBar/MPBar/Label
@onready var damage: Button = $DamageButton/Damage
@onready var current_weapon = $CurrentWeapon
@onready var current_spell = $CurrentSpell
@onready var current_spell_icon = $CurrentSpellIcon
@onready var aug_icon = $AugmentIcon
var player = null

func _ready():
	# Find player and connect signals
	#player = get_node("../Player")
	GameManager.game_pause.connect(game_paused)
	GameManager.game_unpause.connect(game_unpaused)
	player = get_tree().get_first_node_in_group("Player")
	if player:
		##player.health.connect("health_changed", _on_player_health_changed)
		player.health_component.connect("health_changed", _on_player_health_changed)
		player.health_component.connect("health_depleted", _on_player_health_depleted)
		player.stats_component.connect("mp_changed", _on_player_mp_changed)
		player.spell_manager.connect("spell_changed", _on_player_spell_changed)
		#player.connect("xp_changed", _on_player_xp_changed)
		#xp_bar.value = player.player_xp
		#xp_bar.max_value = player.xp_to_level
		health_bar.max_value = player.health_component.max_health
		health_bar.value = player.health_component.current_health
		health_label.text = str(player.health_component.current_health) + "/" + str(player.health_component.max_health)
		mp_bar.max_value = player.stats_component.max_mp
		mp_bar.value = player.stats_component.current_mp
		mp_label.text = str(player.stats_component.current_mp) + "/" + str(player.stats_component.max_mp)
		if player.spell_manager.current_spell != null:
			current_spell.text = player.spell_manager.current_spell.spell_name
			current_spell_icon.texture = player.spell_manager.current_spell.icon
		else:
			current_spell.text = ""
			current_spell_icon.texture = null
		player.augment_state.connect(_on_player_augment_state_changed)
	else:
		print("No Player found")
	damage.button_down.connect(player_damage)

func _on_player_health_changed(new_health):
	health_bar.value = new_health #player.health_component.current_health
	health_label.text = str(player.health_component.current_health) + "/" + str(player.health_component.max_health)

func _on_player_health_depleted():
	# Optional: Show game over screen
	print("Player be dead")

func _on_player_mp_changed(new_mp):
	mp_bar.value = new_mp
	mp_label.text = str(player.stats_component.current_mp) + "/" + str(player.stats_component.max_mp)

func _on_player_spell_changed(new_spell):
	current_spell.text = new_spell.name
	current_spell_icon.texture = new_spell.icon

func _on_player_augment_state_changed(state):
	if state == true:
		aug_icon.show()
	else:
		aug_icon.hide()

func player_damage():
	player.health_component.new_damage(5)

func game_paused():
	hide()

func game_unpaused():
	show()
