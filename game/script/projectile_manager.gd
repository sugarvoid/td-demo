extends Node2D

const p_Projectile = preload("res://game/scene/projectile.tscn")


func add_bullet_to_screen(spawn_pos: Marker2D, parent: Node2D) -> void:
	var projectile = p_Projectile.instantiate()
	projectile.parent_node = parent
#	if parent.is_facing_right:
#		projectile.set_move_dir(1)
#	else:
#		projectile.set_move_dir(-1)
	# projectile.damage_amount = actor.attack
	projectile.global_transform = spawn_pos.global_transform
	self.add_child(projectile)
