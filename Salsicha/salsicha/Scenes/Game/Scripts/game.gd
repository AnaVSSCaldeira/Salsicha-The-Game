extends Node2D

@onready var heartsConteiner = $HUD.get_node("Hearts")
@onready var global = $"/root/Global"
var invulnerable = false
var invulnerable_count = 0
var enemy = preload("res://Scenes/Game/Scenes/enemy.tscn")
var waves_list = {"0": {"enemies_list": [enemy], "types":["default"]},"1": {"enemies_list": [enemy, enemy, enemy], "types":["default", "default", "default"]}, "2": {"enemies_list": [enemy, enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "default", "default", "default", "default"]}, "3": {"enemies_list": [enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "default", "default", "default", "default", "default", "default", "default"]}, "4": {"enemies_list": [enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "default", "default", "default", "default", "default", "default", "default", "default", "default", "default"]}}
var wave = 0
var kill_monsters = 0

func _ready():
	Input.set_custom_mouse_cursor(load("res://Scenes/Game/Images/aim.png"))
	heartsConteiner.setMaxHearts(global.player_life)
	$Screen.visible = false
	$"Powers Spawner/Screen".visible = false
	call_deferred("_spawner")

func _spawner():
	kill_monsters = len(waves_list[str(wave)]["enemies_list"])
	$Spawn.enemy_wave(waves_list, wave)

func game_over():
	$Screen.visible = true
	get_tree().paused = true

func get_powers():
	for node in get_tree().get_nodes_in_group("enemies_bullet"):
		node.queue_free()
	get_tree().paused = true
	$"Powers Spawner/Screen".visible = true
	$"Powers Spawner/Screen/HBoxContainer".create_powers()

	for button in $"Powers Spawner/Screen/HBoxContainer".get_children():
		if button.has_signal("button_pressed"):
			button.connect("button_pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed(id: int, rarity: String):
	global.chosen_power(id, rarity)
	$"Powers Spawner/Screen/HBoxContainer".destroy_powers()
	$"Powers Spawner/Screen".visible = false
	get_tree().paused = false
	global.callv(global.powers[rarity][str(id)]["Function"], global.powers[rarity][str(id)]["Params"])
	new_wave()

func new_wave():
	if wave < len(waves_list):
		get_tree().paused = false
		kill_monsters = len(waves_list[str(wave)]["enemies_list"])
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
	global.restart()
	get_tree().reload_current_scene()
