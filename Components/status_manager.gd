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

#func _ready() -> void:
	#print(status_dictionary)

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

func poison_check(potency: int):
	if potency > status_dictionary["Poison"]:
		print("New Poison applied!")
		status_dictionary["Poison"] = potency
		await get_tree().create_timer(10.0).timeout
		#TODO: Find the best way to manage the individual poison ticks
		# Also needs to be able to be broken/ended on a cleanse/antidote
		# This goes for Regen as well
		poison_end()
	else:
		print("New poison is weaker")
		
	# If the poison status applied is stronger than the current poison, update the potency
	# Then let the initiating target know so the duration can be refreshed

func poison_end():
	status_dictionary["Poison"] = 0

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
	status_dictionary["Regen"] = true
	print("Regen status active!")
	await get_tree().create_timer(10.0).timeout
	regen_end()

func regen_end():
	status_dictionary["Protected"] = false
	status_dictionary["Regen"] = false
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
