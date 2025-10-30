#################################
## State.gd
## State class that defines the basic functions of a state object
## inspired by shaggydev.com
#################################
class_name State
extends Node

@export
var test_move_speed: float = 300 #this is an example and can be removed
@export
var animation_name: String

# Hold a reference to the parent and Animations so that it can be controlled by the state
var parent: CharacterBody2D
var animations: AnimatedSprite2D

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
