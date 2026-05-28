# Inside src/actors/base_fighter_4d.gd
@export var active_hitboxes: Array[Hitbox4D] = []
var global_position_4d: Vector4 = Vector4.ZERO # Absolute location vector (X, Y, Z, W)

func check_combat_collisions(opponent: BaseFighter4D) -> void:
	if not is_attacking:
		return
		
	for my_box in active_hitboxes:
		if my_box.type == Hitbox4D.HitboxType.HITBOX:
			for enemy_box in opponent.get_node("HitboxContainer").get_children():
				if enemy_box.type == Hitbox4D.HitboxType.HURTBOX:
					
					# Execute the hyper-dimensional math evaluation
					if CollisionSolver4D.intersects_4d(my_box, global_position_4d, enemy_box, opponent.global_position_4d):
						# Register clean contact! Inflict structural damage logic
						opponent.take_damage(my_box.damage, visual_mesh_root.global_position)
						is_attacking = false # Prevent multi-hit frame bugs
						return
