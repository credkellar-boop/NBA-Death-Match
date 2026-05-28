# Logic to check for the Signature Move
func check_for_signature_move() -> bool:
	# Requires a specific sequence: Down, Down-Forward, Forward + Punch
	var sig_sequence = [Inputs.DOWN, Inputs.DOWN_FORWARD, Inputs.FORWARD, Inputs.PUNCH]
	return check_sequence(sig_sequence)
# Inside src/actors/input_buffer_4d.gd

func check_sequence(sequence: Array) -> bool:
    # Only allow the sequence to trigger if the last input 
    # was pressed within the last 0.3 seconds
    if time_since_last_input > 0.3:
        return false
        
    return _match_sequence(sequence)
