# src/singletons/roster_manager.gd
extends Node

# A dictionary to hold all loaded HOF profiles for quick access
var database: Dictionary = {}

func _ready() -> void:
    # Automatically load all .tres files from your HOF assets folder
    var dir = DirAccess.open("res://assets/data/hof_rosters/")
    dir.list_dir_begin()
    var file_name = dir.get_next()
    while file_name != "":
        if file_name.ends_with(".tres"):
            var profile = load("res://assets/data/hof_rosters/" + file_name)
            database[profile.player_name] = profile
        file_name = dir.get_next()

func get_profile(name: String) -> PlayerDataResource:
    return database.get(name)
