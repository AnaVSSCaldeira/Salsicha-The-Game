extends Area2D

var bullet_type

func _ready():
	var wait_time = randi_range(1,3)
	$Timer.start(wait_time)

func take_damage(damage):
	if $Life.value == $Life.max_value:
		$Life.visible = true

	$Life.value = $Life.value - damage

	if $Life.value <= 0:
		$Life.value = 0
		var spawn_food = randi_range(1,100)
		if spawn_food <= $"/root/Global".spawn_life:
			var food = preload("res://Scenes/Game/Scenes/food.tscn").instantiate()
			var food_type = randi_range(1,15)
			var food_name

			if food_type >= 1 and food_type <= 5:
				food_name = "maca"
			elif food_type >= 6 and food_type <= 10:
				food_name = "carne"
			else:
				food_name = "cenoura"

			food.get_node("AnimatedSprite2D").animation = food_name
			food.global_position = Vector2(global_position.x,global_position.y)
			get_tree().current_scene.add_child(food)
		get_parent().wave_ends()
		queue_free()

func _on_timer_timeout():
	var  bullet = preload("res://Scenes/Game/Scenes/enemy_bullet.tscn").instantiate()
	bullet.setup(bullet_type)
	bullet.get_node("AnimatedSprite2D").animation = bullet_type
	bullet.global_position = Vector2(global_position.x,global_position.y+100)
	get_tree().current_scene.add_child(bullet)

func setup(enemy_type):
	bullet_type = enemy_type
	match enemy_type:
		"default":
			$AnimatedSprite2D.animation = "default"
			$Life.max_value = 5
			$Life.value = 5
		"strong":
			$AnimatedSprite2D.animation = "strong"
			$Life.max_value = 8
			$Life.value = 8

	$Life.visible = false