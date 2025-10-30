############################
## ph_wanderer_patrol.gd
## Move in a random cardinal direction every 2.5 sec until aggro radius breach (currently hard coded to happen every 3 cycles)
############################
extends State

@export var aggro_state: State
@export var standing_state: State

var dummycounter = 0  #temp variable for checking states
var pick_direction_timer = Timer.new()

func enter() -> void:
	super()
	
	#temp variable until logic is better developed
	dummycounter = 0
	
	_pick_direction_timer() #create a timer
	move_in_direction() #call to get an initial random direction

func process_frame(_delta: float) -> State:
	#if player is in aggro radius, then return aggro_state
	if (dummycounter > 3):
		return aggro_state
	return null

func process_physics(_delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed
	parent.move_and_slide()
	return null

func exit() -> void:
	pick_direction_timer.stop()
	parent.direction.x = 0
	parent.direction.y = 0

#when called pick a cardinal direction to move in.
func move_in_direction() -> void:
	dummycounter += 1 #temp debug variable
	
	var next_move = randi() % 4
	match next_move:
		0:
			parent.direction.x = 0
			parent.direction.y = 1
		1:
			parent.direction.x = 0
			parent.direction.y = -1
		2:
			parent.direction.x = 1
			parent.direction.y = 0
		3:
			parent.direction.x = -1
			parent.direction.y = 0
		_:
			parent.direction.x = 0
			parent.direction.y = 0

func _pick_direction_timer():
	if (!pick_direction_timer.get_parent()): #if we don't have the parent set, add timer as a child and connect the timeout function
		add_child(pick_direction_timer)
		pick_direction_timer.timeout.connect(move_in_direction)

	pick_direction_timer.wait_time = 2.5 #should this be an export variable or defined at the top of the file?
	pick_direction_timer.start()
