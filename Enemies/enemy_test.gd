#########################
## This is a defaulr script for an enemy.
## Edit this comment block to add more description.
## Code for how the enemy behaves is to be written in state machine nodes.
#########################

extends Entity
#class_name #add_your_new_enemy_name

var can_move := true
var direction = Vector2(0,0)

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var state_machine = $State_Machine
@onready var animations = $AnimatedSprite2D


func _ready() -> void:
	var _hurtbox = $HurtBoxComponent
	$HealthComponent.health_depleted.connect(_on_health_depleted)

	state_machine.init(self, animations)

func _physics_process(_delta: float) -> void:
	if can_move == true:
		state_machine.process_physics(_delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_health_depleted():
	call_deferred("queue_free")
