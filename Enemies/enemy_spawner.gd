## A node to spawn an enemy upon map load
## A spawner can have one or more enemies to potentially spawn
## TODO: Adjust the array to have weighted chances for enemies to spawn on load

extends Node2D
class_name EnemySpawner

@export var enemy: Array[PackedScene]
@onready var collider_area = $Area2D/CollisionShape2D

func _spawn_enemy():
	## Spawns an enemy randomly anywhere within the CollisionShape
	var radius : float
	var point : Vector2
	radius = collider_area.shape.get_radius()
	var point_x = randf_range(radius * -1, radius)
	var point_y = randf_range(radius * -1, radius)
	point.x = point_x
	point.y = point_y
	
	if enemy.size() == 1:
		var new_enemy = enemy[0].instantiate()
		new_enemy.global_position = point
		call_deferred("add_child", new_enemy)
	else:
		var array_size = enemy.size()
		var random_num = randi_range(0, array_size-1)
		var new_enemy = enemy[random_num].instantiate()
		new_enemy.global_position = point
		call_deferred("add_child", new_enemy)
