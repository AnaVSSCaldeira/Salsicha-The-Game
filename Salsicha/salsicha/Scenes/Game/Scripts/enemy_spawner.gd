extends Marker2D

func enemy_wave(waves_list, wave):
    var last_positions = []
    var spawn_pos
    for enemy in waves_list[str(wave)]:
        var enemy_child = enemy.instantiate()

        var can_spawn = false
        while can_spawn == false:
            spawn_pos = Vector2(randf_range(200, 1500), randf_range(200, 600))
            if len(last_positions) > 0:
                for pos in last_positions:
                    print(pos.distance_to(spawn_pos) < 50)
                    if pos.distance_to(spawn_pos) < 1000:
                        break
            else:
                can_spawn = true
                
        enemy_child.global_position = spawn_pos
        get_parent().add_child(enemy_child)
    wave += 1