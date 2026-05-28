# src/actors/states/attack_state.gd
class_name AttackState
extends State

@export var attack_duration: float = 0.4
var timer: float = 0.0

func enter() -> void:
	timer = 0.0
	character.velocity = Vector4.ZERO # Stop walking
	character.is_attacking = true
	
	# Fire the punch animation
	if character.animation_tree:
		character.animation_tree.get("parameters/playback").travel("light_punch")

func physics_update(delta: float) -> void:
	timer += delta
	
	# Check for 4D collision on a specific animation frame (e.g., halfway through the punch)
	# In a full game, you sync this to an AnimationPlayer method track
	if timer > 0.15 and timer < 0.25 and character.is_attacking:
		# Assuming 'opponent' reference is passed by the Match Coordinator
		var opponent = character.get_parent().get_node("Player2") if character.name == "Player1" else character.get_parent().get_node("Player1")
		if opponent:
			character.check_combat_collisions(opponent)
			
	# Recovery phase: Transition back to idle when the animation finishes
	if timer >= attack_duration:
		character.is_attacking = false
		state_machine.transition_to("IdleState")
