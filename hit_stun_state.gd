# src/actors/states/hit_stun_state.gd
class_name HitStunState
extends State

@export var base_stun_duration: float = 0.5
@export var knockback_force: float = 8.0

var stun_timer: float = 0.0

func enter() -> void:
	stun_timer = 0.0
	character.is_attacking = false # Cancel any active attacks
	
	# Apply physical knockback in the opposite direction they are facing
	var push_direction = -character.facing_direction
	character.velocity = Vector4(push_direction * knockback_force, 0, 0, 0)
	
	if character.animation_tree:
		character.animation_tree.get("parameters/playback").travel("take_hit")

func physics_update(delta: float) -> void:
	stun_timer += delta
	
	# Apply friction to slow down the knockback slide
	character.velocity.x = move_toward(character.velocity.x, 0.0, 15.0 * delta)
	
	# Exit stun and return control to the player
	if stun_timer >= base_stun_duration:
		state_machine.transition_to("IdleState")
