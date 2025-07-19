extends Node2D
class_name StatsComponent

@export var base_defense : int
@export var current_defense : int
@export var base_strength : int
@export var current_strength : int
@export var base_magic : int
@export var current_magic : int
@export var base_magic_def : int
@export var current_magic_def : int
@export var base_crit_rate : float
@export var current_crit_rate : float
@export var base_physical_dodge_rate : float
@export var current_physical_dodge_rate : float
@export var base_magic_dodge_rate : float
@export var current_magic_dodge_rate : float

@export var current_mp : int
@export var max_mp : int

#####
# Defense = ((base_def + equipment def) +/* positive_modifiers) -// negative_modifiers)
#####
