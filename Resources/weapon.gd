extends Area2D
class_name Weapon

@export var weapon_name : String
@export var weapon_type : Globals.WEAPON_TYPES
@export var elemental_type : Globals.ELEMENT_TYPES

var animation: AnimatedSprite2D
var collider: CollisionShape2D
var damage: int
var damage_type = Globals.DAMAGE_TYPES.PHYSICAL
var physical_power: int
