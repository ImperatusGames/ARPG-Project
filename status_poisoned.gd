#########################
## This is a script to create a poison indicator above a character
## This is not robust. Need to deteremine correct architecture for calling and killing temp graphics.
## Unclear on draw order.  Could be in front or behind character object.
#########################

extends AnimatedSprite2D

var isPoisoned : bool
var poisontimer : int
var time_elapsed := 0.0
var target_character

func _ready() -> void:
	time_elapsed = 0.0
	#TO DO.  THIS IS A HARDCODED 10 SECOND TIMER. SHOULD BE 0 AND SET ELSEWHERE
	poisontimer = 10
	isPoisoned = false
	hide()

func _process(delta: float) -> void:
	get_node("/root/Game/Status_Poisoned").play("overhead")
	
	#TO DO.  THIS IS HARDCODED TO HERO.  SHOULD BE VARIABLE OBJECT.
	self.position = get_node("/root/Game/Hero").position
	#TO DO.  THIS IS A HARDCODED INT AND SHOULD BE SCALED
	self.position.y -= 80
	
	time_elapsed += delta
	if(time_elapsed >= poisontimer):
		queue_free()
	

#Takes input: character. The target that is poisoned.
#Takes input: time. The amount of time the poison will last.
#Creates a poison bubbles effect above the character object
func Poisoned(target_character , time: int):
	self.position = target_character.position()
	self.position.y -= 80 #this "80" should be scaled
	#self.scale = character.scale
	show()
	
	if (isPoisoned == false):
		isPoisoned = true
		poisontimer = time
	else:
		poisontimer += time
		
	
