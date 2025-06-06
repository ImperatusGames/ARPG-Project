class_name Player extends Entity

var speed := 350.0
var xp := 0
var level := 1
var health := 10
var max_health := 50
var magic := 10
var sprite
var collider

func _ready() -> void:
	sprite = $AnimatedSprite2D
	collider = $CollisionShape2D

func _process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if direction.x > 0:
		sprite.play("walk_right")
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.play("walk_right")
		sprite.flip_h = true
	elif direction.y > 0:
		sprite.play("walk_down")
	elif direction.y < 0:
		sprite.play("walk_up")
	else:
		sprite.play("idle")
		
	if Input.is_action_just_pressed("attack"):
		print("Attack button pressed!")

	if Input.is_action_just_pressed("special"):
		print("Special button pressed!")
		#heal()
		fireball()

	if Input.is_action_just_pressed("menu"):
		print("Menu button pressed!")

	#Add state machine for state control between each action

func fireball():
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = global_position
	new_fireball.global_rotation = global_rotation
	add_child(new_fireball)

func heal():
	if health < max_health:
		health += 5
		print("Healed!")
	else:
		print("Health is at max!")
