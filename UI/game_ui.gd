extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar/HPBar
@onready var mp_bar: ProgressBar = $ManaBar/MPBar
@onready var damage: Button = $DamageButton/Damage
var player = null

func _ready():
	# Find player and connect signals
	#player = get_node("../Player")
	player = get_tree().get_first_node_in_group("Player")
	if player:
		##player.health.connect("health_changed", _on_player_health_changed)
		player.health_component.connect("health_changed", _on_player_health_changed)
		player.health_component.connect("health_depleted", _on_player_health_depleted)
		player.stats_component.connect("mp_changed", _on_player_mp_changed)
		#player.connect("xp_changed", _on_player_xp_changed)
		#xp_bar.value = player.player_xp
		#xp_bar.max_value = player.xp_to_level
		health_bar.max_value = player.health_component.max_health
		health_bar.value = player.health_component.current_health
		mp_bar.max_value = player.stats_component.max_mp
		mp_bar.value = player.stats_component.current_mp
	else:
		print("No Player found")
	damage.button_down.connect(player_damage)

func _on_player_health_changed(new_health):
	health_bar.value = new_health #player.health_component.current_health

func _on_player_health_depleted():
	# Optional: Show game over screen
	print("Player be dead")

func _on_player_mp_changed(new_mp):
	mp_bar.value = new_mp

func player_damage():
	player.health_component.new_damage(1)
