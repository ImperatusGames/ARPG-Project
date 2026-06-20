extends Node2D
class_name StatusManager

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
	"Silenced": false
}

func poison_check(potency: int):
	if potency > status_dictionary["Poison"]:
		status_dictionary["Poison"] = potency
		return true
	# If the poison status applied is stronger than the current poison, update the potency
	# Then let the initiating target know so the duration can be refreshed

func poison_end():
	status_dictionary["Poison"] = 0

func freeze_start():
	status_dictionary["Frozen"] = true

func freeze_end():
	status_dictionary["Frozen"] = false

func stun_start():
	status_dictionary["Stunned"] = true

func stun_end():
	status_dictionary["Stunned"] = false

func silence_start():
	status_dictionary["Silenced"] = true

func silence_end():
	status_dictionary["Silenced"] = false

func slow_start():
	status_dictionary["Slowed"] = true

func slow_end():
	status_dictionary["Slowed"] = false
