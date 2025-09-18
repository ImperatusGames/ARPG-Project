############################
## ph_wanderer_patrol.gd
## Move in a random cardinal direction every 2.5 sec until aggro radius breach (currently hard coded to happen every 3 cycles)
############################
extends State

@export
var aggro_state: State

var dummycounter = 0  #temp variable for checking states

func enter() -> void:
	super()
	
	#debug block
	print("in patrol state")
	dummycounter = 0
	
	$Timer_Patrol.start() #start the timer to pick a direction
	_on_timer_patrol_timeout() #call to get an initial random direction

func process_frame(delta: float) -> State:
	#if player is in aggro radius, then return aggro_state
	if (dummycounter > 3):
		return aggro_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = parent.direction * parent.velocity_component.current_speed
	parent.move_and_slide()
	return null

func exit() -> void:
	$Timer_Patrol.stop()
	parent.direction.x = 0
	parent.direction.y = 0

#when called or the timer runs out,
#pick a cardinal direction to move in.
func _on_timer_patrol_timeout() -> void:
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
