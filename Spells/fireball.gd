extends Area2D
class_name Fireball

var travelled_distance := 0.0
var collider

func _ready() -> void:
	area_entered.connect(exploded)
	collider = %CollisionShape2D

func _physics_process(delta: float) -> void:
	const SPEED = 300
	const RANGE = 600
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()

func exploded():
	queue_free()
