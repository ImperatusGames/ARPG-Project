extends Node2D
class_name VelocityComponent

@export var BASE_SPEED : float
@export var current_speed : float
@export var speed_mod : float
@export var slowable : bool
@export var freezeable : bool

func _ready():
	calculate_speed()

func can_be_slowed():
	if slowable == true:
		return true
	else:
		return false

func slowed():
	current_speed = BASE_SPEED / 2
	
func can_be_frozen():
	if freezeable == true:
		return true
	else:
		return false

func frozen():
	current_speed = 0
	
func restore_speed():
	calculate_speed()

func calculate_speed():
	current_speed = BASE_SPEED * (1.0 + speed_mod)
