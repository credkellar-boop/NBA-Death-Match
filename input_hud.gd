# src/ui/input_hud.gd
extends Control

@onready var label = $InputLabel

func _process(_delta: float) -> void:
    # Read the current buffer from the local player
    var buffer = get_parent().get_node("Player1/InputBuffer4D")
    if buffer:
        var sequence = buffer.get_recent_inputs()
        label.text = "BUFFER: " + str(sequence)
