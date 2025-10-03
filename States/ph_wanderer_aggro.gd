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

func process_frame(_delta: float) -> State:
	#if timer ends and player not in aggro radius, then return patrol_state
	#otherwise update parent.direction
	if (checktime == true):
		return patrol_state
	return null

func process_physics(_delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed
	parent.move_and_slide()
	return null

func exit() -> void:
	newtimer.stop()

func _on_newtimer_timeout() -> void:
	checktime = true

#initilize a timer and the bool of checktime to false
func set_aggrostate_timer():
	if (!newtimer.get_parent()): #if we don't have the parent set, add timer as a child and connect the timeout function
		add_child(newtimer)
		newtimer.timeout.connect(_on_newtimer_timeout)
	
	checktime = false
	
	newtimer.wait_time = 5.0 #should this be an export variable or defined at the top of the file?
	newtimer.start()
