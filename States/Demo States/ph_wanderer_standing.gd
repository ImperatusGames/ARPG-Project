############################
## ph_wanderer_standing.gd
## hold position
############################
extends State

var checktime = false
var standing_time = Timer.new()

@export var patrol_state: State
@export var aggro_state: State

func enter() -> void:
	super()
	
	set_aggrostate_timer()

func process_frame(_delta: float) -> State:
	#if timer ends and player not in aggro radius, then return patrol_state
	#otherwise update parent.direction
	if (checktime == true):
		return patrol_state
	parent.direction = Vector2(0,0)
	return null

func process_physics(_delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed

	parent.move_and_slide()
	return null

func exit() -> void:
	standing_time.stop()

func _on_standing_time_timeout() -> void:
	checktime = true

#initilize a timer and the bool of checktime to false
func set_aggrostate_timer():
	if (!standing_time.get_parent()): #if we don't have the parent set, add timer as a child and connect the timeout function
		add_child(standing_time)
		standing_time.timeout.connect(_on_standing_time_timeout)
	
	checktime = false
	
	standing_time.wait_time = 5.0 #should this be an export variable or defined at the top of the file?
	standing_time.start()
