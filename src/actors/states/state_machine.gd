# src/actors/states/state_machine.gd
class_name StateMachine
extends Node

@export var initial_state: State
var current_state: State

func _ready() -> void:
	# Wait one frame to ensure the parent actor is fully loaded
	await owner.ready
	
	# Inject references into every child state node
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.character = get_parent() as BaseFighter4D
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# The core transition engine
func transition_to(target_state_name: String) -> void:
	if not has_node(target_state_name):
		push_error("State Machine transition failed: " + target_state_name + " does not exist.")
		return
		
	var target_state = get_node(target_state_name) as State
	
	current_state.exit()
	target_state.enter()
	current_state = target_state

# Route the Godot physics engine directly into the active state
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
