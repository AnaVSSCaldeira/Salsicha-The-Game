extends Area2D

var life = 3

func _ready():
	print("OI")
	$Life.max_value = life
	$Life.value = life
	$Life.visible = false

func take_damage(damage):
	if $Life.value == $Life.max_value:
		$Life.visible = true

	$Life.value = $Life.value - damage

	if $Life.value <= 0:
		$Life.value = 0
		queue_free()

func _on_timer_timeout():
	var  bullet = preload("res://Scenes/Game/Scenes/enemy_bullet.tscn").instantiate()
	bullet.get_node("AnimatedSprite2D").play("default")
	bullet.global_position = Vector2(global_position.x,global_position.y+100)
	get_tree().current_scene.add_child(bullet)
