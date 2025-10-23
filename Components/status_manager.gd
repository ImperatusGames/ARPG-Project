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
