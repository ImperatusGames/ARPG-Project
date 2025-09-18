#################################
## state_machine.gd
## this allows for both changing to a new state as well as knowing the exiting state
## inspired by shaggydev.com
#################################
extends Node

@export
var starting_state: State
var current_state: State

func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		child.parent = parent

	# Initialize to default state. set in the Inspector after child states are created.
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
