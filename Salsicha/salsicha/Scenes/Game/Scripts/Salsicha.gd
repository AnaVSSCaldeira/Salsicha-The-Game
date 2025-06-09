extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var run
var invulnerable = false
var invulnerable_count
var ammo_delay = false

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:

		if Input.is_key_pressed(KEY_SHIFT):
			run = 300
		else:
			run = 0

		velocity.x = direction * (SPEED + run)
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
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and ammo_delay == false:
		var  bullet = preload("res://Scenes/Game/Scenes/bullet.tscn").instantiate()
		bullet.get_node("AnimatedSprite2D").play($"/root/Global".bullet_type)
		bullet.global_position = Vector2(global_position.x,global_position.y-100)
		get_tree().current_scene.add_child(bullet)
		ammo_delay = true
		$Shoot_delay.start()


func player_damage(damage):
	if $"/root/Global".player_life > 0:
		if invulnerable == false:
			invulnerable_count = 0
			$"/root/Global".player_life -= damage
			var heartsConteiner = get_parent().get_node("HUD").get_node("Hearts")
			heartsConteiner.updateHearts($"/root/Global".player_life)
			invulnerable = true
			$Invulnerable_timer.start(0.25)
	else:
		get_parent().game_over()

func _on_invulnerable_timer_timeout():
	visible = not visible
	invulnerable_count += 1
	print(invulnerable_count)

	if invulnerable_count == 6:
		invulnerable = false
		$Invulnerable_timer.stop()
		visible = true


func _on_shoot_delay_timeout():
	ammo_delay = false