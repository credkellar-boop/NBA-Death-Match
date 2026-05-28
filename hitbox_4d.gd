# src/actors/hitbox_4d.gd
class_name Hitbox4D
extends Node

enum HitboxType { HURTBOX, HITBOX }

@export var type: HitboxType = HitboxType.HURTBOX
@export var damage: float = 0.0

# Define the center spatial offset position (X, Y, Z, W)
@export var position_4d: Vector4 = Vector4.ZERO

# Define the hyper-extents (Width, Height, Depth, Hyper-thickness)
@export var extents_4d: Vector4 = Vector4(1.0, 1.0, 1.0, 1.0)

# Returns the absolute minimum boundary vector in 4D space
func get_min_bound(parent_global_pos_4d: Vector4) -> Vector4:
	return (parent_global_pos_4d + position_4d) - (extents_4d / 2.0)

# Returns the absolute maximum boundary vector in 4D space
func get_max_bound(parent_global_pos_4d: Vector4) -> Vector4:
	return (parent_global_pos_4d + position_4d) + (extents_4d / 2.0)
