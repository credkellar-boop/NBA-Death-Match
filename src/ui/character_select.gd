# src/ui/character_select.gd
extends Control

@export var roster: Array[PlayerDataResource] # Drag your .tres HOF files here
@onready var grid = $GridContainer
@onready var preview = $PreviewViewport/CharacterPreview

func _ready() -> void:
	# Populate the select grid dynamically
	for player in roster:
		var btn = Button.new()
		btn.text = player.player_name
		btn.pressed.connect(_on_player_selected.bind(player))
		grid.add_child(btn)

func _on_player_selected(profile: PlayerDataResource) -> void:
	# Store the selection globally or pass to the MatchCoordinator
	GameGlobal.p1_selection = profile
	print("Selected: ", profile.player_name)
	
	# Update the preview viewport model
	preview.change_model(profile.character_mesh)
