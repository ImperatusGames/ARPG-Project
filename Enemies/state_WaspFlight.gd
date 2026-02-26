############################
## state WaspFlight
## 
## At random intervals pick a cardnial direction to move, then wait and repeat.
## While waiting hover up and down slightly.
############################
extends State

var pick_direction_timer = Timer.new()
var rest_bool = true
var dontpicksametwice = 4

#for every other state, you must export a variable of it as a State
#standing state is not used, but keeping here for now for clarity
@export var standing_state: State

func enter() -> void:
	super()

	_pick_direction_timer() #create a timer
	move_in_direction() #call to get an initial random direction

func process_frame(_delta: float) -> State:

	#this will make the enemy wobbly like it is flying
	if (rest_bool == false): #variable naming is bad here, implies the opposite state.
		var hover = (-1 + randi() % 3 )
		parent.direction = Vector2(0, hover)
	return null

func process_physics(_delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed

	parent.move_and_slide()
	return null

func exit() -> void:
	#add your code here.
	#this is used for logic upon exiting this state.  typically cleanup or pass.
	pass


#when called pick a cardinal direction to move in.
func move_in_direction() -> void:
	
	#change how long each action takes after each action betwen half a second and two seconds.
	pick_direction_timer.wait_time = randf_range(0.5, 2.0)
	
	#alternate between rest and a cardinal direction. do not pick same direction twice.
	#slightly faster in x direction.
	if (rest_bool == true):
		parent.direction.x = 0
		parent.direction.y = 0
		rest_bool = false
	else:
		rest_bool = true
		var next_move = randi() % 4
		match next_move:
			0:
				parent.direction.x = 0
				parent.direction.y = 3
				if (dontpicksametwice == 0):
					parent.direction.y *= -1
				dontpicksametwice = 0
			1:
				parent.direction.x = 0
				parent.direction.y = -3
				if (dontpicksametwice == 1):
					parent.direction.y *= -1
				dontpicksametwice = 1
			2:
				parent.direction.x = 4
				parent.direction.y = 0
				if (dontpicksametwice == 2):
					parent.direction.x *= -1
				dontpicksametwice = 2
			3:
				parent.direction.x = -4
				parent.direction.y = 0
				if (dontpicksametwice == 3):
					parent.direction.x *= -1
				dontpicksametwice = 3
			_:
				parent.direction.x = 0
				parent.direction.y = 0

func _pick_direction_timer():
	if (!pick_direction_timer.get_parent()): #if we don't have the parent set, add timer as a child and connect the timeout function
		add_child(pick_direction_timer)
		pick_direction_timer.timeout.connect(move_in_direction)

	pick_direction_timer.wait_time = 2.0 #initial time between direction changes
	pick_direction_timer.start()
