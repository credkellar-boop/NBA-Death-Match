# src/actors/states/idle_state.gd
class_name IdleState
extends State

func enter() -> void:
	# Halt all momentum
	character.velocity = Vector4.ZERO
	# Play the base animation
	if character.animation_tree:
		character.animation_tree.get("parameters/playback").travel("idle")

func physics_update(_delta: float) -> void:
	var input_buffer = character.get_node("InputBuffer4D") as InputBuffer4D
	
	# Transition to Attack State if Punch is in the buffer
	var punch_sequence = [InputBuffer4D.Inputs.PUNCH]
	if input_buffer.check_sequence(punch_sequence):
		state_machine.transition_to("AttackState")
		return
		
	# Transition to Walk State if directional input is held
	var walk_dir = Input.get_axis("ui_left", "ui_right")
	if walk_dir != 0:
		state_machine.transition_to("WalkState")
		return
