#################################
## State.gd
## State class that defines the basic functions of a state object
## inspired by shaggydev.com
#################################
class_name State
extends Node

# Some variables to engage with.  to be edited...
@export
var animation_name: String
@export
var test_move_speed: float = 300

# Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D

#to be edited.  this assumes every state will want an animation
#could also be implemented on the child instead.
func enter() -> void:
	#parent.animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
