extends Node
class_name Attack

enum Statuses {FREEZE, KNOCKBACK, POISON, SLOW, STUN}

var attack_damage: int
var attack_position: Vector2
var status: Array[Statuses]
