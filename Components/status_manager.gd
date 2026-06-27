extends Node2D
class_name StatusManager

signal stunned_state
signal silence_state

@export var frozen_immune : bool
@export var stunned_immune : bool
@export var knocked_back_immune : bool
@export var slowed_immune : bool
@export var poisoned_immune : bool
@export var silence_immune : bool

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var velocity_component : VelocityComponent = get_node("../VelocityComponent")
@onready var poison_timer : Timer = $PoisonTimer
@onready var regen_timer : Timer = $RegenTimer

func _ready() -> void:
	poison_timer.timeout.connect(poison_end)
	regen_timer.timeout.connect(regen_end)

#var active_statuses : Array[StatusEffect]

var status_dictionary = {
	"Poison": 0,
	"Frozen": false,
	"Stunned": false,
	"Slowed": false,
	"Silenced": false,
	"Protected": false,
	"Magic Guard": false,
	"Regen": false
}

#Create an array of Statuses
#When a new status is applied, append the new status object to the array
#When the status effect ends, it is deleted from the array
#If the effect is cleansed, it is deleted from the array as well

func poison_check(potency: int):
	if potency > status_dictionary["Poison"]:
		print("New Poison applied!")
		status_dictionary["Poison"] = potency
		const POISON = preload("res://Spells/StatusEffects/status_poisoned.tscn")
		var poison_scene = POISON.instantiate()
		poison_scene.potency = potency
		add_child(poison_scene)
		poison_scene.connect("poison_damage", poison_damage)
		poison_timer.start()
	elif potency == status_dictionary["Poison"]:
		poison_timer.start()
		print("Refreshed Poison duration!")
	else:
		print("New poison is weaker")
		
	# If the poison status applied is stronger than the current poison, update the potency
	# Then let the initiating target know so the duration can be refreshed

func poison_end():
	status_dictionary["Poison"] = 0
	var poison_node = get_node("Status_Poisoned")
	poison_node.disconnect("poison_damage", poison_damage)
	poison_node.poison_ended()

func freeze_start():
	status_dictionary["Frozen"] = true
	velocity_component.immobile()
	await get_tree().create_timer(3.0).timeout
	freeze_end()

func freeze_end():
	status_dictionary["Frozen"] = false
	velocity_component.calculate_speed()

func stun_start():
	status_dictionary["Stunned"] = true
	velocity_component.immobile()
	stunned_state.emit(true)
	await get_tree().create_timer(3.0).timeout
	stun_end()

func stun_end():
	status_dictionary["Stunned"] = false
	stunned_state.emit(false)
	velocity_component.calculate_speed()

func silence_start():
	status_dictionary["Silenced"] = true
	silence_state.emit(true)
	print("Player silenced!")
	await get_tree().create_timer(10.0).timeout
	silence_end()

func silence_end():
	status_dictionary["Silenced"] = false
	print("Player silence ended!")
	silence_state.emit(false)

func slow_start():
	status_dictionary["Slowed"] = true
	await get_tree().create_timer(15.0).timeout
	slow_end()

func slow_end():
	status_dictionary["Slowed"] = false

func protect_start():
	status_dictionary["Protected"] = true
	await get_tree().create_timer(15.0).timeout
	protect_end()

func protect_end():
	status_dictionary["Protected"] = false

func magic_guard_start():
	status_dictionary["Magic Guard"] = true
	await get_tree().create_timer(15.0).timeout
	magic_guard_end()

func magic_guard_end():
	status_dictionary["Magic Guard"] = false

func regen_start():
	if status_dictionary["Regen"] == false:
		print("Regen applied!")
		const REGEN = preload("res://Spells/StatusEffects/status_regen.tscn")
		var regen_scene = REGEN.instantiate()
		add_child(regen_scene)
		regen_scene.connect("regen", regen_heal)
		regen_timer.start()
	else:
		regen_timer.start()
		print("Regen refreshed!")

func regen_end():
	status_dictionary["Regen"] = false
	var regen_node = get_node("Status_Regen")
	regen_node.disconnect("regen", regen_heal)
	regen_node.regen_ended()
	print("Regen ended")

func cleanse():
	poison_end()
	freeze_end()
	stun_end()
	silence_end()
	slow_end()

func dispel():
	protect_end()
	magic_guard_end()
	regen_end()

func can_be_frozen():
	if frozen_immune == true:
		return false
	else:
		return true

func can_be_slowed():
	if slowed_immune == true:
		return false
	else:
		return true

func can_be_stunned():
	if stunned_immune == true:
		return false
	else:
		return true

func can_be_silenced():
	if silence_immune == true:
		return false
	else:
		return true

func can_be_poisoned():
	if poisoned_immune == true:
		return false
	else:
		return true

func poison_damage(potency: int):
	#print("Poison damage: ", potency)
	health_component.poison_damage(potency)

func poison_exists():
	if has_node("Status_Poisoned") == true:
		return true
	else:
		return false

func regen_heal():
	health_component.static_restore()

func regen_exists():
	if has_node("Status_Regen"):
		return true
	else:
		return false
