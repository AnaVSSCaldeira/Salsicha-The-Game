extends Node2D

@onready var heartsConteiner = $HUD.get_node("Hearts")

func _ready():
	heartsConteiner.setMaxHearts($"/root/Global".player_life)

func _input(event):
	if Input.is_key_pressed(KEY_W):
		take_damage(1)
		
func take_damage(damage):
	if $"/root/Global".player_life > 0:
		$"/root/Global".player_life -= damage
		heartsConteiner.updateHearts($"/root/Global".player_life)

func handle_enemy_damage(body, damage):
	body.take_damage(damage)
