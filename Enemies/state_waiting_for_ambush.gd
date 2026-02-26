############################
## Waiting in ambush state
## 
## Holds position until player is above or below then sets move state
############################
extends State

@onready var player = get_node("/root/Game/Hero") #this only works if the Hero node is always in this path.

#for every other state, you must export a variable of it as a State
@export var ambush_state: State
#@export var aggro_state: State

func enter() -> void:
	super()
	#add your code here.
	#tyically initial logic like playing a sound or starting a timer.

func process_frame(_delta: float) -> State:
	

	if (player.position.x <= parent.position.x + 20 && player.position.x >= parent.position.x -20):
		return ambush_state
	else:
		parent.direction = Vector2(0,0)
	return null

func process_physics(_delta: float) -> State:
	#add your code here.
	#typically this will adjust the position or speed of the enemy.
	parent.velocity = parent.direction * parent.velocity_component.current_speed

	parent.move_and_slide()
	return null

func exit() -> void:
	#add your code here.
	#this is used for logic upon exiting this state.  typically cleanup or pass.
	pass


func set_some_logic():
	#you can create more functions and use them for switching states
	pass
