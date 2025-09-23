############################
## ph_wanderer_aggro.gd
## move towards the player.  (currently set to not move)
############################
extends State

var checktime = false
var newtimer = Timer.new()


@export
var patrol_state: State

func enter() -> void:
	super()
	
	set_aggrostate_timer()

func process_frame(delta: float) -> State:
	#if timer ends and player not in aggro radius, then return patrol_state
	#otherwise update parent.direction
	if (checktime == true):
		return patrol_state	
	return null

func process_physics(delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed
	parent.move_and_slide()
	return null

func exit() -> void:
	newtimer.stop()

func _on_newtimer_timeout() -> void:
	checktime = true

#initilize the bool 'checktime' to false.
#initilize a timer.
func set_aggrostate_timer():
	checktime = false
	add_child(newtimer) #are we constantly creating timers without destroying them?
	newtimer.wait_time = 5.0 #should this be an export variable or defined at the top of the file?
	newtimer.start()
	newtimer.timeout.connect(_on_newtimer_timeout) #maybe can be done with a lambda instead of function call
