extends Node
class_name Attack

enum Statuses {FREEZE, KNOCKBACK, POISON, SLOW, STUN}
enum Attack_Types {PHYSICAL, MAGICAL}

var attack_damage: int
var attack_position: Vector2
var status: Array[Statuses]
var attack_type: Attack_Types
var physical_power: int
var magical_power: int
