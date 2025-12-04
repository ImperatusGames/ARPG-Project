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

#required references to child objects
@onready
var state_machine = $State_Machine
@onready
var animations = $AnimatedSprite2D


func _ready() -> void:
	var _hurtbox = $HurtBoxComponent
	$HealthComponent.health_depleted.connect(_on_health_depleted)

	state_machine.init(self, animations) #start the state machine in its default state which is set on the State_Machine node.

func _physics_process(_delta: float) -> void:
	if can_move == true:
		state_machine.process_physics(_delta)  #state machine will call its own process_physics based on what state it is in.

func _process(delta: float) -> void:
	state_machine.process_frame(delta)  #state machince will call its own logic based on what state it is in.

func _on_health_depleted():
	print ("wanderer defeated")
	call_deferred("queue_free")
