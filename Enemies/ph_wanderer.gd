#########################
## This is a script to create an enemy that moves
## Currently will move in a cardinal direction changing every 2.5 sec
## Need to implement move direction while in aggro state
#########################

extends Entity
class_name ph_wanderer

#not all block variables included
var can_move := true
var direction = Vector2(0,0)
@onready var velocity_component: VelocityComponent = $VelocityComponent

enum WandererStates {Patrol , Aggro}
var enemy_state = WandererStates.Patrol  #assigning the variable in ready didn't work

func _ready() -> void:
	var hurtbox = $HurtBoxComponent
	_on_timer_patrol_timeout()
	$HealthComponent.health_empty.connect(_on_health_empty)

func _physics_process(_delta: float) -> void:
	#if $AggroRadius is colliding with player:
	#	enemy_state = WandererStates.Aggro
	#   add logic for direction to be normalizzed vector towards the player 
	if can_move == true:
		velocity = direction * velocity_component.current_speed
		move_and_slide()

func _on_health_empty():
	print ("wanderer defeated")
	call_deferred("queue_free")

#when called or the timer runs out,
#pick a cardinal direction to move in.
#or check to return to patrol state
func _on_timer_patrol_timeout() -> void:
	match enemy_state:
		WandererStates.Patrol:
			var next_move = randi() % 4
			match next_move:
				0:
					direction.x = 0
					direction.y = 1
				1:
					direction.x = 0
					direction.y = -1
				2:
					direction.x = 1
					direction.y = 0
				3:
					direction.x = -1
					direction.y = 0
				_:
					direction.x = 0
					direction.y = 0
		WandererStates.Aggro:
			print("in aggro state")
			#if enemy out of range:
			#enemy_state = WandereStates.Patrol
