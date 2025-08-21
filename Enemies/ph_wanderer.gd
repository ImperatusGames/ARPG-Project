#########################
## This is a script to create an enemy that moves
## Currently will move in a preset direction changing every 2.5 sec
## Need to implement random
#########################

extends Entity
class_name ph_wanderer

#not all block variables included
#var health := 1
var can_move := true
var dir_num := 0
var direction = Vector2(-1,0) #should be random & possibly set elsewhere
@onready var velocity_component: VelocityComponent = $VelocityComponent

func _ready() -> void:
	var hurtbox = $HurtBoxComponent
	$HealthComponent.health_empty.connect(_on_health_empty)

func _physics_process(_delta: float) -> void:
	if can_move == true:
		velocity = direction * velocity_component.current_speed
		move_and_slide()

func _on_health_empty():
	print ("wanderer defeated")
	call_deferred("queue_free")

#after timer expires (hard coded to 2.5 sec
#will move to the next direction
func _on_timer_patrol_timeout() -> void:
	if dir_num == 0:
		direction.x = 0
		direction.y = 1
	elif dir_num == 1:
		direction.x = 0
		direction.y = -1
	elif dir_num == 2:
		direction.x = 1
		direction.y = 0
	elif dir_num == 3:
		direction.x = -1
		direction.y = 0
		
	dir_num += 1  #change this to a random number gen
	if dir_num > 3:
		dir_num = 0
