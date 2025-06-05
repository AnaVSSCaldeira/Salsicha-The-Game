extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
			$mochila.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
			$mochila.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if Input.is_key_pressed(KEY_W):
		var  bullet = preload("res://Scenes/Game/Scenes/bullet.tscn").instantiate()
		bullet.get_node("AnimatedSprite2D").play($"/root/Global".bullet_type)
		bullet.global_position = Vector2(global_position.x,global_position.y-100)
		get_tree().current_scene.add_child(bullet)
