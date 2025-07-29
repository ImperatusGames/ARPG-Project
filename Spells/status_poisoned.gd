#########################
## This is a script to create a poison indicator above a character
## This is not robust. Need to deteremine correct architecture for calling and killing temp graphics.
## Unclear on draw order.  Could be in front or behind character object.
#########################

extends AnimatedSprite2D

var is_poisoned : bool
var poison_timer : int
var time_elapsed := 0.0
var target_character : Entity

func _ready() -> void:
	#var timer = $Timer
	$Timer.timeout.connect(poison_ended)
	play("overhead")
	time_elapsed = 0.0
	#TO DO.  THIS IS A HARDCODED 10 SECOND TIMER. SHOULD BE 0 AND SET ELSEWHERE
	poison_timer = 10
	is_poisoned = false
	self.global_position = get_parent().global_position
	#TO DO.  THIS IS A HARDCODED INT AND SHOULD BE SCALED
	self.position.y -= 80
	#hide()

func _process(_delta: float) -> void:
	pass
	
#Takes input: character. The target that is poisoned.
#Takes input: time. The amount of time the poison will last.
#Creates a poison bubbles effect above the character object
func poisoned(target : Entity):
	self.position = target.position
	self.position.y -= 80 #this "80" should be scaled
	#self.scale = character.scale
	#if (is_poisoned == false):
		#is_poisoned = true
		#poison_timer = time
	#else:
		#poison_timer += time
		
func poison_ended():
	print("No more poison!")
	queue_free()
