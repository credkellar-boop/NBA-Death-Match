# src/actors/collision_solver_4d.gd
class_name CollisionSolver4D
extends Node

# Evaluates intersection across X, Y, Z, AND W axes
static func intersects_4d(box_a: Hitbox4D, pos_a: Vector4, box_b: Hitbox4D, pos_b: Vector4) -> bool:
	var min_a = box_a.get_min_bound(pos_a)
	var max_a = box_a.get_max_bound(pos_a)
	
	var min_b = box_b.get_min_bound(pos_b)
	var max_b = box_b.get_max_bound(pos_b)
	
	# Check all 4 dimensions for spatial separation overlap
	var overlap_x = (min_a.x <= max_b.x) and (max_a.x >= min_b.x)
	var overlap_y = (min_a.y <= max_b.y) and (max_a.y >= min_b.y)
	var overlap_z = (min_a.z <= max_b.z) and (max_a.z >= min_b.z)
	var overlap_w = (min_a.w <= max_b.w) and (max_a.w >= min_b.w) # The 4th Dimension Check
	
	# It only counts as a clean hit if it intersects in all 4 dimensions simultaneously
	return overlap_x and overlap_y and overlap_z and overlap_w
# Add directly to src/actors/collision_solver_4d.gd

static func clamp_to_united_center(current_position: Vector4, court_l: float, court_w: float) -> Vector4:
	var clamped_pos = current_position
	
	# Clamp player inside the physical hardwood lines of the Chicago Bulls floor
	clamped_pos.x = clamp(clamped_pos.x, -court_l / 2.0, court_l / 2.0)
	clamped_pos.z = clamp(clamped_pos.z, -court_w / 2.0, court_w / 2.0)
	
	# Clamp the Hyper-Plane (W-Axis) to prevent infinite dimensional drift 
	# This keeps the characters within a stable local neighborhood of alternate timelines
	clamped_pos.w = clamp(clamped_pos.w, -10.0, 10.0)
	
	return clamped_pos
# src/debug/perf_monitor.gd
func _process(delta):
    var fps = Engine.get_frames_per_second()
    if fps < 55:
        push_warning("Performance drop detected: ", fps, " FPS")
