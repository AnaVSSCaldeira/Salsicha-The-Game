extends Node2D

@onready var heartsConteiner = $HUD.get_node("Hearts")
var invulnerable = false
var invulnerable_count = 0

func _ready():
	Input.set_custom_mouse_cursor(load("res://Scenes/Game/Images/aim.png"))
	heartsConteiner.setMaxHearts($"/root/Global".player_life)

func game_over():
	pass

func get_powers():
	pass