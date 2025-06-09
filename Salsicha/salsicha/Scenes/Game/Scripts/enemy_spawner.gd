extends Marker2D

var enemy1 = preload("res://Scenes/Game/Scenes/enemy.tscn")
@export var waves_list = {}
@export var wave: int

func _ready():
    waves_list = {"0": [enemy1, enemy1, enemy1], "1": [enemy1, enemy1, enemy1, enemy1, enemy1, enemy1]}
    wave = 0
    call_deferred("_enemy_wave")

func _enemy_wave():
    for enemy in waves_list[str(wave)]:
        var enemy_child = enemy.instantiate()
        enemy_child.global_position = global_position
        get_parent().add_child(enemy_child)
        print(enemy_child)
    wave += 1