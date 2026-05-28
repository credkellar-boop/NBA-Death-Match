# src/singletons/game_global.gd
extends Node

var p1_selection: PlayerDataResource
var p2_selection: PlayerDataResource

func start_match() -> void:
	# Transition from the Menu to the Level
	get_tree().change_scene_to_file("res://src/levels/united_center_arena.tscn")
