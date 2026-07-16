## Spell will cleanse negative effects
## Augmented spell will transfer negative effects to nearby enemy

extends Spell
class_name Cleanse_Spell

@onready var status_manager : StatusManager = get_node("../StatusManager")
@onready var animator : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animator.animation_finished.connect(cleansing)
	animator.play("default")

func cleansing():
	if aug_state == true:
		status_manager.cleanse()
		print("Augmented Cleanse!")
	else:
		status_manager.cleanse()
		print("Non-augmented Cleanse!")
		
	call_deferred("queue_free")
