############################
## state horizontal
## 
## need to add more information
############################
extends State

#for every other state, you must export a variable of it as a State
#@export var patrol_state: State
@export var standing_state: State

func enter() -> void:
	super()
	
	#add your code here.
	#tyically initial logic like playing a sound or starting a timer.

func process_frame(_delta: float) -> State:
	#add your code here what you want to happen on the frame.
	#typically setting logic for changing state
	parent.direction = Vector2(-1,0)
	return null

func process_physics(_delta: float) -> State:
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
