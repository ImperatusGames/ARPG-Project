extends Resource
class_name PlayerStats

var base_defense : int
var current_defense : int
var base_strength : int
var current_strength : int
var base_magic : int
var current_magic : int
var base_magic_def : int
var current_magic_def : int
var base_crit_rate : float
var current_crit_rate : float
var base_physical_dodge_rate : float
var current_physical_dodge_rate : float
var base_magic_dodge_rate : float
var current_magic_dodge_rate : float

var current_hp : int
var max_hp : int
var current_mp : int
var max_mp : int

var current_experience : int
var xp_to_level : int
var level : int

#####
# Defense = ((base_def + equipment def) +/* positive_modifiers) -// negative_modifiers)
#####
