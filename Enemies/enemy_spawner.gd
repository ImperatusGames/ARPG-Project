extends Area2D
class_name EnemySpawner

@export var enemy_array: Array[PackedScene]
#@onready var enemy = preload("res://Enemies/enemy_wasp.tscn")

func _spawn_enemy():
	#enemy.instantiate()
	#get_parent().add_child(enemy)
	if enemy_array.size() == 1:
		var enemy = enemy_array[0]
		#enemy.instantiate()
		add_sibling(enemy)
	else:
		var array_size = enemy_array.size()
		var random_num = randi_range(0, array_size)
		var enemy = enemy_array[random_num]
		enemy.instantiate()
		add_child(enemy)
