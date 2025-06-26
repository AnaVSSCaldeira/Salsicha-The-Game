extends Marker2D

func enemy_wave(waves_list, wave, p1, p2):
	if wave == 10:
		var boss = waves_list[str(wave)]["enemies_list"][0]
		var boss_child = boss.instantiate()
		boss_child.setup(p1, p2)
		boss_child.global_position = Vector2(980, p1.y)
		get_parent().add_child(boss_child)

	else:
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
			count += 1
		wave += 1
