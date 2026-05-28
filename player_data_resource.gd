# src/actors/player_data_resource.gd
class_name PlayerDataResource
extends Resource

@export_category("Bio")
@export var player_name: String = "Legend"
@export var hof_year: int = 2026

@export_category("Base Fighter Attributes")
@export var health_pool: float = 1000.0
@export var base_speed: float = 5.0
@export var attack_power_modifier: float = 1.0

@export_category("Cinematic Assets")
@export var character_mesh: PackedScene # Links to the pre-rendered or 3D character model
@export var animation_library: AnimationLibrary # Custom combat animations

@export_category("4D Combat Matrix")
@export var hyper_dimensional_energy: float = 100.0
@export var signature_move_state_id: int = 1000
