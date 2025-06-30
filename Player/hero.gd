class_name Player extends Entity

var speed := 350.0
var sprite
var collider
var last_direction : String

#Turn last_direction into an enum for Up/Down/Left/Right for spell purposes

func _ready() -> void:
	sprite = $AnimatedSprite2D
	collider = $CollisionShape2D
	
func _process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if direction.x > 0:
		sprite.play("walk_right")
		last_direction = "right"
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.play("walk_right")
		last_direction = "left"
		sprite.flip_h = true
	elif direction.y > 0:
		sprite.play("walk_down")
		last_direction = "down"
	elif direction.y < 0:
		sprite.play("walk_up")
		last_direction = "up"
	else:
		sprite.play("idle")
		
		
	if Input.is_action_just_pressed("attack"):
		print("Attack button pressed!")

	if Input.is_action_just_pressed("special"):
		print("Special button pressed!")
		#heal()
		#fireball(last_direction)
		#defender()

	if Input.is_action_just_pressed("menu"):
		print("Menu button pressed!")

	#Add state machine for state control between each action

func fireball(player_direction: String):
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = global_position
	new_fireball.global_rotation = global_rotation
	new_fireball.player_direction = player_direction
	add_sibling(new_fireball)

#func heal():
	#if health < max_health:
		#health += 5
		#print("Healed!")
	#else:
		#print("Health is at max!")

#func defender():
	#if get_tree().get_node("def_timer") == true:
		#get_tree().get_node("def_timer").start
	#else:
		#current_defense = base_defense * 2
		#print(current_defense)
		#var def_timer = get_tree().create_timer(5.0).timeout
	#
	#await get_tree().get_node("def_timer").timeout
	#current_defense = base_defense
	#print(current_defense)
