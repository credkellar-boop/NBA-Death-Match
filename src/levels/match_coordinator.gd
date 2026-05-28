# src/levels/match_coordinator.gd
class_name MatchCoordinator
extends Node

@export_category("Arena Setup")
@export var level_scene: PackedScene = preload("res://src/levels/united_center_4d.tscn")
@export var match_time_limit: float = 99.0

@export_category("Fighter Selection Profiles")
@export var player_1_profile: PlayerDataResource
@export var player_2_profile: PlayerDataResource

# Internal Engine States
var match_timer: float
var current_round: int = 1
var p1_wins: int = 0
var p2_wins: int = 0
var is_round_active: bool = false

# Runtime Instance Trackers
var current_level_instance: UnitedCenter4D
var p1_actor: BaseFighter4D
var p2_actor: BaseFighter4D

@onready var cinematic_camera: Marker3D = $CinematicDirector

func _ready() -> void:
	match_timer = match_time_limit
	initialize_match_environment()

func initialize_match_environment() -> void:
	# 1. Instantiate the United Center map into the tree
	current_level_instance = level_scene.instantiate() as UnitedCenter4D
	add_child(current_level_instance)
	
	# 2. Spawn the generic 4D Fighter base template scenes
	var fighter_scene = load("res://src/actors/base_fighter_4d.tscn")
	
	p1_actor = fighter_scene.instantiate() as BaseFighter4D
	p1_actor.player_profile = player_1_profile
	p1_actor.global_position_4d = Vector4(-5.0, 0.0, 0.0, 0.0) # Left side of court
	p1_actor.facing_direction = 1
	add_child(p1_actor)
	
	p2_actor = fighter_scene.instantiate() as BaseFighter4D
	p2_actor.player_profile = player_2_profile
	p2_actor.global_position_4d = Vector4(5.0, 0.0, 0.0, 0.0) # Right side of court
	p2_actor.facing_direction = -1
	add_child(p2_actor)
	
	# 3. Hook the actors up to the cinematic camera system
	cinematic_camera.player_1 = p1_actor
	cinematic_camera.player_2 = p2_actor
	
	# 4. Bind event callbacks for damage impacts
	p1_actor.actor_damaged.connect(_on_fighter_impact)
	p2_actor.actor_damaged.connect(_on_fighter_impact)
	
	start_round_sequence()

func start_round_sequence() -> void:
	match_timer = match_time_limit
	is_round_active = true
	print("ROUND ", current_round, " - FIGHT!")

func _process(delta: float) -> void:
	if not is_round_active:
		return
		
	# Process Match Clock
	match_timer -= delta
	if match_timer <= 0:
		evaluate_round_time_out()

func _on_fighter_impact(shake_intensity: float, freeze_duration: float) -> void:
	# Pass heavy damage events right to the camera shake system
	cinematic_camera.trigger_hit_shake(shake_intensity, freeze_duration)
	
	# Trigger crowd roar and camera flashes inside the United Center
	if current_level_instance:
		current_level_instance.trigger_stadium_impact_event(shake_intensity)
		
	# Check if either actor collapsed during the frame update
	if p1_actor.current_health <= 0:
		end_round_sequence(2) # Player 2 Wins Round
	elif p2_actor.current_health <= 0:
		end_round_sequence(1) # Player 1 Wins Round

func evaluate_round_time_out() -> void:
	is_round_active = false
	if p1_actor.current_health > p2_actor.current_health:
		end_round_sequence(1)
	elif p2_actor.current_health > p1_actor.current_health:
		end_round_sequence(2)
	else:
		end_round_sequence(0) # Sudden Death Draw

func end_round_sequence(winner_id: int) -> void:
	is_round_active = false
	
	if winner_id == 1:
		p1_wins += 1
		print(p1_actor.player_profile.player_name, " WINS THE ROUND!")
	elif winner_id == 2:
		p2_wins += 1
		print(p2_actor.player_profile.player_name, " WINS THE ROUND!")
	
	# Check for overall Deathmatch Victory (Best of 3)
	if p1_wins >= 2 or p2_wins >= 2:
		declare_match_champion(winner_id)
	else:
		current_round += 1
		# Reset positions for next round setup
		p1_actor.current_health = p1_actor.player_profile.health_pool
		p2_actor.current_health = p2_actor.player_profile.health_pool
		p1_actor.global_position_4d = Vector4(-5.0, 0.0, 0.0, 0.0)
		p2_actor.global_position_4d = Vector4(5.0, 0.0, 0.0, 0.0)
		start_round_sequence()

func declare_match_champion(winner_id: int) -> void:
	var champ_name = p1_actor.player_profile.player_name if winner_id == 1 else p2_actor.player_profile.player_name
	print("MATCH OVER! ", champ_name, " IS THE CELEBRITY DEATHMATCH CHAMPION!")
	# Transition back to main menu loop or character select scene
# Inside src/levels/match_coordinator.gd

func spawn_player(player_name: String, spawn_pos: Vector4, facing: int):
    var profile = RosterManager.get_profile(player_name)
    var fighter = load("res://src/actors/base_fighter_4d.tscn").instantiate()
    
    # Configure actor with HOF stats
    fighter.player_profile = profile
    fighter.global_position_4d = spawn_pos
    fighter.facing_direction = facing
    
    # Apply the Clay Shader to the imported model
    var clay_material = load("res://assets/materials/wet_clay.tres")
    fighter.get_node("MeshInstance3D").set_surface_override_material(0, clay_material)
    
    add_child(fighter)
# Add to _ready() in match_coordinator.gd
func _ready() -> void:
    var p1_data = RosterManager.get_profile("Michael Jordan")
    if p1_data:
        print("Success: ", p1_data.player_name, " loaded into the engine.")
    else:
        print("Error: Jordan profile not found in database.")
# src/levels/match_coordinator.gd

func start_match(p1_name: String, p2_name: String):
    # 1. Load the arena submodule
    var arena = load("res://src/levels/UnitedCenter4D/scene.tscn").instantiate()
    add_child(arena)
    
    # 2. Spawn fighters into the arena's coordinate space
    var p1 = spawn_player(p1_name, Vector4(0, 0, 0, 1), 1)
    var p2 = spawn_player(p2_name, Vector4(0, 0, 0, -1), -1)
    
    arena.add_child(p1)
    arena.add_child(p2)
