extends Node2D

func _ready():
	$Controls.visible = false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/Scenes/Game.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_how_to_play_pressed():
	get_tree().paused = true
	$Controls.visible = !($Controls.visible)

func _on_close_pressed():
	get_tree().paused = false
	$Controls.visible = !($Controls.visible)
