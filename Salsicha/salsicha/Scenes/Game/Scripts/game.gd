extends Node2D

@onready var heartsConteiner = $HUD.get_node("Hearts")
var invulnerable = false
var invulnerable_count = 0
var enemy1 = preload("res://Scenes/Game/Scenes/enemy.tscn")
var waves_list = {"0": [enemy1], "1": [enemy1, enemy1, enemy1, enemy1, enemy1, enemy1]}
var wave = 0
var kill_monsters = 0

func _ready():
	Input.set_custom_mouse_cursor(load("res://Scenes/Game/Images/aim.png"))
	heartsConteiner.setMaxHearts($"/root/Global".player_life)
	$Screen.visible = false
	call_deferred("_spawner")

func _spawner():
	kill_monsters = len(waves_list[str(wave)])
	$Spawn.enemy_wave(waves_list, wave)

func game_over():
	$Screen.visible = true
	get_tree().paused = true

func get_powers():
	get_tree().paused = true
	$"Powers Spawner".visible = true
	$"Powers Spawner/HBoxContainer".create_powers()

func new_wave():
	get_tree().paused = false
	kill_monsters = len(waves_list[str(wave)])
	$Spawn.enemy_wave(waves_list, wave)

func _on_exit_pressed():
	get_tree().quit()

func wave_ends():
	kill_monsters -= 1
	if kill_monsters == 0:
		wave += 1
		get_powers()

func _on_restart_pressed():
	get_tree().paused = false
	$"/root/Global".restart()
	get_tree().reload_current_scene()
