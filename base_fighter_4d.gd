# src/actors/base_fighter_4d.gd
class_name BaseFighter4D
extends Node4D  # Inherits hyper-dimensional spatial coordinate system nodes

# Inject our custom configurations
@export var player_profile: PlayerDataResource

# Dynamic internal runtime properties
var current_health: float
var is_attacking: bool = false
var facing_direction: int = 1 # 1 = Right, -1 = Left

# Signals to broadcast state transformations to the cinematic camera system
signal actor_damaged(intensity: float, freeze_duration: float)
signal state_changed(new_state: String)

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var visual_mesh_root: Marker3D = $VisualMeshRoot

func _ready() -> void:
	if not player_profile:
		push_error("Fighter Actor initialization failed: Missing PlayerDataResource.")
		return
		
	# Initialize stats directly from our structured data file
	current_health = player_profile.health_pool
	setup_actor_mesh()

func setup_actor_mesh() -> void:
	# Clean any default developer testing models from the pipeline
	for child in visual_mesh_root.get_children():
		child.queue_free()
		
	# Instantiate the selected Hall of Fame player's model directly into the viewport
	var instance = player_profile.character_mesh.instantiate()
	visual_mesh_root.add_child(instance)
	
	# Bind their custom animation rig directly to the global combat controller
	if player_profile.animation_library:
		var anim_player: AnimationPlayer = $AnimationPlayer
		anim_player.add_animation_library(player_profile.player_name.to_snake_case(), player_profile.animation_library)

func take_damage(amount: float, attacker_position: Vector3) -> void:
	# Calculate structural damage adjustments based on data attributes
	current_health -= amount
	
	# Trigger cinematic feedback loops (Screen shake, hit stops)
	# High impact hits trigger severe camera frame freezes
	var shake_intensity = clamp(amount * 0.05, 0.1, 1.5)
	var freeze_time = clamp(amount * 0.003, 0.05, 0.3)
	actor_damaged.emit(shake_intensity, freeze_time)
	
	if current_health <= 0:
		execute_deathmatch_termination()

func execute_deathmatch_termination() -> void:
	state_changed.emit("K.O.")
	# Drop input listening windows, break collision bounds, and trigger the final cinematic death animations
	set_physics_process(false)
