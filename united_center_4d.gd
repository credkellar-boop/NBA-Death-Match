# src/levels/united_center_4d.gd
class_name UnitedCenter4D
extends Node3D

@export var stadium_name: String = "United Center, Chicago"
@export var court_length: float = 28.65 # Standard NBA court length in meters
@export var court_width: float = 15.24  # Standard NBA court width in meters

# References to interactive stadium models
@onready var jumbotron_animation: AnimationPlayer = $Jumbotron/AnimationPlayer
@onready var crowd_particles: GPUParticles3D = $CrowdSystem/FlashCameras
@onready var world_environment: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	# Load the cinematic post-processing profiles we created earlier
	world_environment.environment = load("res://src/cinematography/post_process_environment.tres")
	initialize_stadium_audio()

func initialize_stadium_audio() -> void:
	$Audio/CrowdAmbience.play()

# Called by the main Match Coordinator when an actor triggers a major combo hit
func trigger_stadium_impact_event(intensity: float) -> void:
	if intensity > 1.0:
		# Play dynamic crowd roar and strobe lights
		jumbotron_animation.play("stadium_flash_frenzy")
		crowd_particles.emitting = true
		$Audio/CrowdCheer.play()
	else:
		jumbotron_animation.play("jumbotron_loop")
# src/levels/UnitedCenter4D/united_center_4d.gd
extends Node3D

@onready var jumbotron = $Jumbotron
@onready var env = $WorldEnvironment

func _ready() -> void:
    # Initialize the high-fidelity cinematic look
    _setup_aces_tonemapping()
    # Trigger the arena intro sequence
    jumbotron.play_intro_animation()

func _setup_aces_tonemapping() -> void:
    env.environment.tonemap_mode = Environment.TONEMAP_ACES
    env.environment.tonemap_exposure = 1.2
