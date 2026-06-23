extends Node2D
class_name VelocityComponent

@export var BASE_SPEED : float
@export var current_speed : float
@export var speed_mod : float

@onready var stats_component : StatsComponent = get_node("../StatsComponent")
@onready var health_component : HealthComponent = get_node("../HealthComponent")
@onready var status_manager : StatusManager = get_node("../StatusManager")

func _ready():
	calculate_speed()

#func can_be_slowed():
	#if slowable == true:
		#return true
	#else:
		#return false

func slowed():
	current_speed = BASE_SPEED / 2
	
#func can_be_frozen():
	#if freezeable == true:
		#return true
	#else:
		#return false

func immobile():
	current_speed = 0
	
func restore_speed():
	calculate_speed()

func calculate_speed():
	current_speed = BASE_SPEED * (1.0 + speed_mod)

func set_run_speed():
	speed_mod = 1.0
	calculate_speed()

func set_walk_speed():
	speed_mod = 0.0
	calculate_speed()
