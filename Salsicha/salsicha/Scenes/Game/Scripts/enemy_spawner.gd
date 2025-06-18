extends Marker2D

func enemy_wave(waves_list, wave):
	var last_positions = []
	var spawn_pos
	var count = 0
	for enemy in waves_list[str(wave)]["enemies_list"]:
		var enemy_child = enemy.instantiate()
		enemy_child.setup(waves_list[str(wave)]["types"][count])

		var can_spawn = false
		var tries = 0
		while tries < 100:
			spawn_pos = Vector2(randf_range(200, 1500), randf_range(200, 600))
			if len(last_positions) > 0:
				for pos in last_positions:
					if pos.distance_to(spawn_pos) < 50:
						break
			else:
				can_spawn = true
				last_positions.append(spawn_pos)
			
			tries += 1
				
		enemy_child.global_position = spawn_pos
		get_parent().add_child(enemy_child)
	wave += 1
