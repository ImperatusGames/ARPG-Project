class_name Player extends Entity

@onready var sprite_player = $AnimationPlayer
@onready var sprite = $Sprite2D
var collider
var last_direction : String
var is_attacking : bool
var is_casting : bool
var is_moving : bool
var can_move : bool
var can_attack : bool
var can_cast : bool
var is_running : bool

enum States {IDLE, WALKING, RUNNING, ATTACKING, CASTING}

var state: States = States.IDLE

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var stats_component: StatsComponent = $StatsComponent

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
	is_running = false
	
func _physics_process(_delta: float) -> void:
	if can_move == true:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * velocity_component.current_speed
		
		if direction.x > 0:
			sprite_player.play("walk_right")
			last_direction = "right"
			sprite.flip_h = false
		elif direction.x < 0:
			sprite_player.play("walk_right")
			last_direction = "left"
			sprite.flip_h = true
		elif direction.y > 0:
			sprite_player.play("walk_down")
			last_direction = "down"
		elif direction.y < 0:
			sprite_player.play("walk_up")
			last_direction = "up"
		else:
			sprite_player.play("idle")
	
		move_and_slide()
	
	#Add state machine for state control between each action

func fireball(player_direction: String):
	const FIREBALL = preload("res://Spells/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = global_position
	new_fireball.global_rotation = global_rotation
	new_fireball.player_direction = player_direction
	new_fireball.magical_power = stats_component.current_magic
	
	#if player_direction == "up":
		#new_fireball.global_position.y -= 50
	#elif player_direction == "down":
		#new_fireball.global_position.y += 80
	#elif player_direction == "left":
		#new_fireball.global_position.x -= 60
	#elif player_direction == "right":
		#new_fireball.global_position.x += 60
	
	new_fireball.set_collision_mask_value(5, true)
	new_fireball.set_collision_layer_value(4, true)
	print("Fireball MPow", new_fireball.magical_power)
	add_child(new_fireball)
	await new_fireball.has_finished
	
func sword_attack(last_dir: String):
	var direction = last_dir
	const SWORD = preload("res://Weapons/sword.tscn")
	var new_sword = SWORD.instantiate()
	new_sword.physical_power = stats_component.current_strength
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
	await new_sword.animation_finished

func _input(event):
	#var direction = Input.get_vector("move_down", "move_left", "move_right", "move_up")
	#if event.is_action_pressed("move_down"):
		#pass
	#elif event.is_action_pressed("move_up"):
		#pass
	#elif event.is_action_pressed("move_left"):
		#pass
	#elif event.is_action_pressed("move_right"):
		#pass
	if event.is_action_pressed("attack"):
		if can_attack == true: 
			is_attacking = true
			can_move = false
			can_cast = false
			can_attack = false
			await sword_attack(last_direction)
			is_attacking = false
			can_move = true
			can_cast = true
			can_attack = true
	elif event.is_action_pressed("special"):
		if can_cast == true: 
			is_casting = true
			can_move = false
			can_attack = false
			can_cast = false
			await fireball(last_direction)
			is_casting = false
			can_move = true
			can_attack = true
			can_cast = true
	elif event.is_action_pressed("menu"):
		print("Menu button pressed!")
	elif event.is_action_pressed("run_toggle"):
		if is_running == true:
			velocity_component.set_walk_speed()
			is_running = false
		else:
			velocity_component.set_run_speed()
			is_running = true
	
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
