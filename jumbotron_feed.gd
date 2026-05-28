# src/levels/jumbotron_feed.gd
class_name JumbotronFeed
extends SubViewport

@export var match_director: Marker3D

@onready var internal_cam: Camera3D = $Camera3D

func _ready() -> void:
	# Configure the viewport rendering pass optimizing performance
	size = Vector2i(512, 384) # 4:3 Retro Stadium Aspect Ratio
	render_target_update_mode = SubViewport.UPDATE_ALWAYS
	render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS

func _process(_delta: float) -> void:
	if not match_director:
		return
		
	# Mirror the global positional transformation matrices of the cinematic camera
	var main_cam = match_director.get_node("Camera3D") as Camera3D
	if main_cam:
		internal_cam.global_transform = main_cam.global_transform
		internal_cam.fov = main_cam.fov
