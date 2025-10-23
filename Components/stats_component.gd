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

@export var max_mp : int
@export var current_mp : int

var defense_bonus := 1.0
var strength_bonus := 1.0
var magic_bonus := 1.0
var magic_def_bonus := 1.0

var defense_penalty := 1.0
var strength_penalty := 1.0
var magic_penalty := 1.0
var magic_def_penalty := 1.0

var protect_status := false

func _ready() -> void:
	current_defense = base_defense
	current_strength = base_strength
	current_magic = base_magic
	current_magic_def = base_magic_def
	current_mp = max_mp

func set_defense():
	current_defense = round((base_defense * defense_bonus) * defense_penalty)

func set_strength():
	current_strength = round((base_strength * strength_bonus) * strength_penalty)

func set_magic():
	current_magic = round((base_magic * magic_bonus) * magic_penalty)

func set_magic_def():
	current_magic_def = round((base_magic_def * magic_def_bonus) * magic_def_penalty)

func set_defense_bonus_on():
	defense_bonus = 1.5
	set_defense()

func set_defense_bonus_off():
	defense_bonus = 1.0
	set_defense()

func set_strength_bonus_on():
	strength_bonus = 1.5
	set_strength()

func set_strength_bonus_off():
	strength_bonus = 1.0
	set_strength()

func set_magic_bonus_on():
	magic_bonus = 1.5
	set_magic()

func set_magic_bonus_off():
	magic_bonus = 1.0
	set_magic()

func set_magic_def_bonus_on():
	magic_def_bonus = 1.5
	set_magic_def()

func set_magic_def_bonus_off():
	magic_def_bonus = 1.0
	set_magic_def()

func set_defense_penalty_on():
	defense_penalty = 0.5
	set_defense()

func set_defense_penalty_off():
	defense_penalty = 1.0
	set_defense()

func set_strength_penalty_on():
	strength_penalty = 0.5
	set_strength()

func set_strength_penalty_off():
	strength_penalty = 1.0
	set_strength()

func set_magic_penalty_on():
	magic_penalty = 0.5
	set_magic()

func set_magic_penalty_off():
	magic_penalty = 1.0
	set_magic()

func set_magic_def_penalty_on():
	magic_def_penalty = 0.5
	set_magic_def()

func set_magic_def_penalty_off():
	magic_def_penalty = 1.0
	set_magic_def()
#####
# Defense = ((base_def + equipment def) +/* positive_modifiers) -// negative_modifiers)
#####
