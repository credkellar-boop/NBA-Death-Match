# src/actors/input_buffer_4d.gd
class_name InputBuffer4D
extends Node

# The maximum frames an input stays valid in the buffer stack
@export var buffer_window_frames: int = 15

# Our input vocabulary map
enum Inputs { NONE, FORWARD, BACK, DOWN, UP, PUNCH, KICK, PHASE_W }

# A structured timestamped record of an input event
struct InputEventRecord:
	var input_type: Inputs
	var frame_timestamp: int

# The actual circular array holding recent inputs
var input_history: Array[InputEventRecord] = []
var current_frame: int = 0

func _physics_process(_delta: float) -> void:
	current_frame += 1
	clean_expired_buffer_frames()
	read_raw_controller_inputs()

func read_raw_controller_inputs() -> void:
	# Capture raw directional vector inputs based on facing direction
	var parent_actor = get_parent() as BaseFighter4D
	var facing = parent_actor.facing_direction if parent_actor else 1
	
	if Input.is_action_just_pressed("ui_right"):
		add_to_buffer(Inputs.FORWARD if facing == 1 else Inputs.BACK)
	elif Input.is_action_just_pressed("ui_left"):
		add_to_buffer(Inputs.BACK if facing == 1 else Inputs.FORWARD)
		
	if Input.is_action_just_pressed("ui_down"):
		add_to_buffer(Inputs.DOWN)
	elif Input.is_action_just_pressed("ui_up"):
		add_to_buffer(Inputs.UP)
		
	# Attack buttons
	if Input.is_action_just_pressed("combat_punch"):
		add_to_buffer(Inputs.PUNCH)
	if Input.is_action_just_pressed("combat_kick"):
		add_to_buffer(Inputs.KICK)
	if Input.is_action_just_pressed("phase_w"):
		add_to_buffer(Inputs.PHASE_W)

func add_to_buffer(type: Inputs) -> void:
	var record = InputEventRecord.new()
	record.input_type = type
	record.frame_timestamp = current_frame
	input_history.append(record)

func clean_expired_buffer_frames() -> void:
	# Clear out any inputs that are older than our allowed window
	while not input_history.is_empty() and (current_frame - input_history[0].frame_timestamp) > buffer_window_frames:
		input_history.pop_front()

# Check if a specific sequence of commands exists within the current buffer window
func check_sequence(sequence: Array[Inputs]) -> bool:
	if input_history.size() < sequence.size():
		return false
		
	var seq_index = sequence.size() - 1
	# Walk backwards through the history to check if the latest inputs match the combo
	for i in range(input_history.size() - 1, -1, -1):
		if input_history[i].input_type == sequence[seq_index]:
			seq_index -= 1
			if seq_index < 0:
				input_history.clear() # Clear buffer on successful sequence execution
				return true
	return false
