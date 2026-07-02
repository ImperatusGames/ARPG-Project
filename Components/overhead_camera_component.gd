extends Camera2D
class_name OverheadCameraComponent

@export var map_top_left := Vector2.ZERO
@export var map_size := Vector2(1024, 768)
@export var edge_scenery_overlap := Vector2(96, 96)
@export var current_on_ready := true
@export var follow_smoothing_enabled := true
@export var follow_smoothing_speed := 8.0

func _ready() -> void:
	_apply_camera_limits()
	position_smoothing_enabled = follow_smoothing_enabled
	position_smoothing_speed = follow_smoothing_speed
	limit_smoothed = follow_smoothing_enabled
	if current_on_ready:
		make_current()

func _apply_camera_limits() -> void:
	if map_size.x <= 0 or map_size.y <= 0:
		return
	limit_left = roundi(map_top_left.x - edge_scenery_overlap.x)
	limit_top = roundi(map_top_left.y - edge_scenery_overlap.y)
	limit_right = roundi(map_top_left.x + map_size.x + edge_scenery_overlap.x)
	limit_bottom = roundi(map_top_left.y + map_size.y + edge_scenery_overlap.y)
