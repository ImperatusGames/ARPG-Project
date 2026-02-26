############################
## If hero is above or below enemy, move in that direction
## 
## TWO BUGS TO FIX. 1 the timer is not implemented correctly. 2. Logic is wrong seems to do both direcitons
############################
extends State

@onready var player = get_node("/root/Game/Hero") #this only works if the Hero node is always in this path.
var newtimer = Timer.new()
var needtostop = false
#for every other state, you must export a variable of it as a State
@export var waiting_state: State

func enter() -> void:
	super()
	
	if (player.position.y < parent.position.y):
		parent.direction.y = -5
	if (player.position.y > parent.position.y):
		parent.direction.y = 5
	setruntimer()

func process_frame(_delta: float) -> State:
	
	if (needtostop == true):
		return waiting_state
		
	return null

func process_physics(_delta: float) -> State:
	#add your code here.
	#typically this will adjust the position or speed of the enemy.
	parent.velocity = parent.direction * parent.velocity_component.current_speed

	parent.move_and_slide()
	return null

func exit() -> void:
	newtimer.stop()

func _on_newtimer_timeout() -> void:
	if (player.position.y < parent.position.y):
		parent.direction.y = -5
		setruntimer()
	if (player.position.y > parent.position.y):
		parent.direction.y = 5
		setruntimer()
	else:
		needtostop = true
	
#initilize a timer and the bool of checktime to false
func setruntimer():
	if (!newtimer.get_parent()): #if we don't have the parent set, add timer as a child and connect the timeout function
		add_child(newtimer)
		newtimer.timeout.connect(_on_newtimer_timeout)
	
	newtimer.wait_time = 2.0 #should this be an export variable or defined at the top of the file?
	newtimer.start()
