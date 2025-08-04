extends Node2D

@onready var hud_variables = $HUD.get_node("VBoxContainer")
@onready var heartsConteiner = $HUD.get_node("Hearts")
@onready var global = $"/root/Global"
@onready var wave_label = $Wave/Count
@onready var p1_position = $P1.position
@onready var p2_position = $P2.position
var invulnerable = false
var invulnerable_count = 0
var enemy = preload("res://Scenes/Game/Scenes/enemy.tscn")
var boss = preload("res://Scenes/Game/Scenes/Boss.tscn")
var waves_list = {"0": {"enemies_list": [enemy], "types":["default"]},"1": {"enemies_list": [enemy, enemy, enemy], "types":["default", "default", "default"]}, "2": {"enemies_list": [enemy, enemy, enemy, enemy], "types":["default", "default", "default", "default"]}, "3": {"enemies_list": [enemy, enemy, enemy, enemy], "types":["default", "default", "default", "default"]}, "4": {"enemies_list": [enemy, enemy, enemy, enemy], "types":["default", "default", "default", "strong"]}, "5": {"enemies_list": [enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "strong", "strong", "default"]}, "6": {"enemies_list": [enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "strong", "strong", "strong"]}, "7": {"enemies_list": [enemy, enemy, enemy, enemy, enemy], "types":["default", "default", "strong", "strong", "strong"]}, "8": {"enemies_list": [enemy, enemy, enemy, enemy, enemy], "types":["default", "strong", "strong", "strong", "strong"]}, "9": {"enemies_list": [enemy, enemy, enemy, enemy, enemy], "types":["strong", "strong", "strong", "strong", "strong"]}, "10": {"enemies_list": [boss], "types":["default"]}}
var wave = 0
var kill_monsters = 0

func _ready():
	Input.set_custom_mouse_cursor(load("res://Scenes/Game/Images/aim.png"))
	heartsConteiner.setMaxHearts(global.player_life)
	$Screen.visible = false
	$"Powers Spawner/Screen".visible = false
	call_deferred("_spawner")
	wave_label.text = str(wave+1)
	hud_variables.get_node("Attack").get_node("count").text = str(global.bullet_damage)
	hud_variables.get_node("Veloc player").get_node("count").text = str(global.player_speed)
	hud_variables.get_node("Veloc bullet").get_node("count").text = str(global.bullet_speed)
	$Pause.visible = false

func _process(delta):
	if global.player_life_change:
		heartsConteiner.addMoreHearts(1)
		global.player_life_change = false
	hud_variables.get_node("Attack").get_node("count").text = str(global.bullet_damage)
	hud_variables.get_node("Veloc player").get_node("count").text = str(global.player_speed)
	hud_variables.get_node("Veloc bullet").get_node("count").text = str(global.bullet_speed)

func _spawner():
	kill_monsters = len(waves_list[str(wave)]["enemies_list"])
	$Spawn.enemy_wave(waves_list, wave, p1_position, p2_position)

func game_over():
	$Screen.visible = true
	get_tree().paused = true

func get_powers():
	for node in get_tree().get_nodes_in_group("bullet"):
		node.queue_free()
	for node in get_tree().get_nodes_in_group("enemy_bullet"):
		node.queue_free()
	for node in get_tree().get_nodes_in_group("healing"):
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
		wave_label.text = str(wave+1)
		get_tree().paused = false
		kill_monsters = len(waves_list[str(wave)]["enemies_list"])
		$Spawn.enemy_wave(waves_list, wave, p1_position, p2_position)

func _on_exit_pressed():
	get_tree().quit()

func wave_ends():
	kill_monsters -= 1
	if kill_monsters == 0:
		$Delay_new_wave.start()

func _on_restart_pressed():
	get_tree().paused = false
	global.restart()
	get_tree().reload_current_scene()

func _on_delay_new_wave_timeout():
	wave += 1
	get_powers()

func _on_continue_pressed():
	get_tree().paused = false
	$Pause.visible = !($Pause.visible)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().paused = true
			$Pause.visible = !($Pause.visible)
