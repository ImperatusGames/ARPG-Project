class_name Player extends Entity

@onready var sprite_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var stats_component: StatsComponent = $StatsComponent
@onready var spell_manager: SpellManager = $SpellManager
@onready var weapon_manager: WeaponManager = $WeaponManager


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

#Turn last_direction into an enum for Up/Down/Left/Right for spell purposes

var nearby_chests: Array[Node] = []

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
	
func _input(event):
	if event.is_action_pressed("attack"):
		if can_attack == true:
			if nearby_chests.size() > 0:
				if open_nearby_chest():
					return 
			is_attacking = true
			can_move = false
			can_cast = false
			can_attack = false
			weapon_manager.last_direction = last_direction
			await weapon_manager.weapon_attack()
			is_attacking = false
			can_move = true
			can_cast = true
			can_attack = true
	elif event.is_action_pressed("spell"):
		if can_cast == true: 
			is_casting = true
			can_move = false
			can_attack = false
			can_cast = false
			spell_manager.last_direction = last_direction
			await spell_manager.cast_spell()
			is_casting = false
			can_move = true
			can_attack = true
			can_cast = true
	elif event.is_action_pressed("item"):
		print("Item used!")
	elif event.is_action_pressed("menu"):
		const MENU_UI = preload("res://Spells/fireball.tscn")
		var new_menu_ui = MENU_UI.instantiate()
		add_sibling(new_menu_ui)
		#get_tree().paused = true
		print("Menu button pressed!")
	elif event.is_action_pressed("run_toggle"):
		if is_running == true:
			velocity_component.set_walk_speed()
			is_running = false
		else:
			velocity_component.set_run_speed()
			is_running = true

func open_nearby_chest() -> bool:
	for chest in nearby_chests:
		if chest.open():
			return true
	print("No valid chest to open")
	return false

func _on_chest_body_entered(body: Node) -> void:
	nearby_chests.append(body)  

func _on_chest_body_exited(body: Node) -> void:
	var index = nearby_chests.find(body)
	if index != -1:
		nearby_chests.remove_at(index)
