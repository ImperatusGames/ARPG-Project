############################
## ph_wanderer_aggro.gd
## move towards the player.  (currently set to not move)
############################
extends State

var checktime = false

@export
var patrol_state: State

func enter() -> void:
	super()
	
	#debug and temp variables block
	print("in aggro state")
	checktime = false
	$Timer_Aggro.start()

func process_frame(delta: float) -> State:
	#if timer ends and player not in aggro radius, then return patrol_state
	#otherwise update parent.direction
	if checktime == true:
		return patrol_state	
	return null

func process_physics(delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed
	parent.move_and_slide()
	return null

func exit() -> void:
	$Timer_Aggro.stop()

func _on_timer_aggro_timeout() -> void:
	checktime = true
