# src/actors/states/state.gd
class_name State
extends Node

# References to the main character body and the state manager
var character: BaseFighter4D
var state_machine: StateMachine

# Called perfectly on the frame the state becomes active
func enter() -> void:
	pass

# Called every frame while this state is active
func physics_update(_delta: float) -> void:
	pass

# Called on the frame before the character transitions to a different state
func exit() -> void:
	pass
