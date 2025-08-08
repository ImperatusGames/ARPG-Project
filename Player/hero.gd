class_name Player extends Entity

@onready var sprite_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var state_machine = $AnimationTree["parameters/playback"]
var collider
var last_direction : String
var is_attacking : bool
var is_casting : bool
var is_moving : bool
var can_move : bool
var can_attack : bool
var can_cast : bool

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent

#Turn last_direction into an enum for Up/Down/Left/Right for spell purposes

func _ready() -> void:
	collider = $CollisionShape2D
	is_attacking = false
	is_casting = false
	is_moving = false
	can_move = true
	can_attack = true
	can_cast = true
	last_direction = "right"
	
func _physics_process(_delta: float) -> void:
	#var current = state_machine.get_current_node()
	if can_move == true:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * velocity_component.current_speed
		
		#if direction.x > 0:
			#state_machine.travel("walk_right")
			#last_direction = "right"
			#sprite.flip_h = false
		#elif direction.x < 0:
			#state_machine.travel("walk_right")
			#last_direction = "left"
			#sprite.flip_h = true
		#elif direction.y > 0:
			#state_machine.travel("walk_down")
			#last_direction = "down"
		#elif direction.y < 0:
			#state_machine.travel("walk_up")
			#last_direction = "up"
		#if velocity.x > 0:
			#state_machine.travel("walk_right")
			#print("Walking right")
		#else:
			#state_machine.travel("idle")

		
	if Input.is_action_just_pressed("attack") && can_attack == true:
		#print("Attack button pressed!")
		#Need to add an Attack animation and, while it's playing, set player Velocity to 0
		is_attacking = true
		can_move = false
		can_cast = false
		can_attack = false
		sword_attack(last_direction)
		is_attacking = false
		can_move = true
		can_cast = true
		can_attack = true

	if Input.is_action_just_pressed("special") && can_cast == true:
		#print("Special button pressed!")
		#Need to add a Casting animation and, while it's playing, set player Velocity to 0
		#heal()
		is_casting = true
		can_move = false
		can_attack = false
		can_cast = false
		fireball(last_direction)
		is_casting = false
		can_move = true
		can_attack = true
		can_cast = true
		#defender()

	if Input.is_action_just_pressed("menu"):
		print("Menu button pressed!")
	
	move_and_slide()
	

	#Add state machine for state control between each action

func fireball(player_direction: String):
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = global_position
	new_fireball.global_rotation = global_rotation
	new_fireball.player_direction = player_direction
	
	#if player_direction == "up":
		#new_fireball.global_position.y -= 50
	#elif player_direction == "down":
		#new_fireball.global_position.y += 80
	#elif player_direction == "left":
		#new_fireball.global_position.x -= 60
	#elif player_direction == "right":
		#new_fireball.global_position.x += 60
	
	#new_fireball.collision_mask = 5
	new_fireball.set_collision_mask_value(5, true)
	new_fireball.set_collision_layer_value(4, true)
	add_child(new_fireball)

func sword_attack(last_dir: String):
	var direction = last_dir
	const SWORD = preload("res://Weapons/sword.tscn")
	var new_sword = SWORD.instantiate()
	if direction == "right":
		new_sword.global_position.x += 60
	elif direction == "left":
		new_sword.rotation_degrees = 180
		new_sword.global_position.x -= 60
	elif direction == "up":
		new_sword.global_position.y -= 60
		new_sword.rotation_degrees = -90
	elif direction == "down":
		new_sword.global_position.y += 75
		new_sword.rotation_degrees = 90
	add_child(new_sword)

func _input(event):
	var direction = Input.get_vector("move_down", "move_left", "move_right", "move_up")
	if event.is_action_pressed("move_down"):
		pass
	elif event.is_action_pressed("move_up"):
		pass
	elif event.is_action_pressed("move_left"):
		pass
	elif event.is_action_pressed("move_right"):
		pass
	elif event.is_action_pressed("attack"):
		pass
	elif event.is_action_pressed("special"):
		pass
	elif event.is_action_pressed("menu"):
		pass
	
	var current = state_machine.get_current_node()
	if can_move == true:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * velocity_component.current_speed
		
		if direction.x > 0:
			#state_machine.travel("walk_right")
			last_direction = "right"
			sprite.flip_h = false
		elif direction.x < 0:
			#state_machine.travel("walk_right")
			last_direction = "left"
			sprite.flip_h = true
		elif direction.y > 0:
			#state_machine.travel("walk_down")
			last_direction = "down"
		elif direction.y < 0:
			#state_machine.travel("walk_up")
			last_direction = "up"
		#else:
			#state_machine.travel("idle")

		
	if Input.is_action_just_pressed("attack") && can_attack == true:
		#print("Attack button pressed!")
		is_attacking = true
		can_move = false
		can_cast = false
		can_attack = false
		sword_attack(last_direction)
		is_attacking = false
		can_move = true
		can_cast = true
		can_attack = true

	if Input.is_action_just_pressed("special") && can_cast == true:
		#print("Special button pressed!")
		#heal()
		is_casting = true
		can_move = false
		can_attack = false
		can_cast = false
		fireball(last_direction)
		is_casting = false
		can_move = true
		can_attack = true
		can_cast = true
		#defender()

	if Input.is_action_just_pressed("menu"):
		print("Menu button pressed!")
	
	move_and_slide()
		
	
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
