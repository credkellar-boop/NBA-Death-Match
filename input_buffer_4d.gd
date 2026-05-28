# Logic to check for the Signature Move
func check_for_signature_move() -> bool:
	# Requires a specific sequence: Down, Down-Forward, Forward + Punch
	var sig_sequence = [Inputs.DOWN, Inputs.DOWN_FORWARD, Inputs.FORWARD, Inputs.PUNCH]
	return check_sequence(sig_sequence)
