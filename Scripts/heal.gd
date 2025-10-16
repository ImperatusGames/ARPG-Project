extends Node
class_name HealEffect

var is_spell_heal : bool
var heal_power : int
var spell_power : int
var heal_factor : float

#If the healing effect comes from an item, spell_power and factor are not needed
#If it comes from a spell, those will be part of the formula and shouldn't be equal to 0
