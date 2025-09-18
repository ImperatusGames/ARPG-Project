#########################
## This is a script to create an enemy that moves
## Move in a cardinal direction changing every 2.5 sec unless in aggro state
## logic handled in state machine child objects
#########################

extends Entity
class_name ph_wanderer

#not all block variables included
var can_move := true
var direction = Vector2(0,0)
@onready var velocity_component: VelocityComponent = $VelocityComponent

##new state machine here
@onready
var state_machine = $State_Machine


func _ready() -> void:
	var hurtbox = $HurtBoxComponent
	$HealthComponent.health_empty.connect(_on_health_empty)
	
	state_machine.init(self) #start the state machine in its default state

func _physics_process(_delta: float) -> void:
	if can_move == true:
		state_machine.process_physics(_delta)  #the state machine will call its own process_physics based on what state it is in.

func _process(delta: float) -> void:
	state_machine.process_frame(delta)  #the state machince will call its own logic based on what state it is in.

func _on_health_empty():
	print ("wanderer defeated")
	call_deferred("queue_free")
