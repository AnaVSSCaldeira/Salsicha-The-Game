extends CharacterBody2D

@onready var global = $"/root/Global"

var run
var invulnerable = false
var invulnerable_count
var ammo_delay = false
var power = false
var calango
var jump_count = 0
var current_animation = "default"
var shield = true

func _ready():
	$ball_dash_collision.disabled = true
	$AnimatedSprite2D.animation = current_animation
	$mochila.visible = true
	$mochila.animation = current_animation
	scale = Vector2(1,1)
	calango = 0
	power = false
	$Cooldown_image.visible = false
	$Shield.visible = false
	$Shield/CollisionShape2D.disabled = true

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jump_count = 0
			velocity.y = global.player_jump
			$dog_jump.play()
		else:
			if global.can_double_jump and jump_count < 1:
				velocity.y = global.player_jump
				$dog_jump.play()
				jump_count += 1

	var direction = Input.get_axis("left", "right")
	if direction:

		if Input.is_key_pressed(KEY_SHIFT):
			if $"/root/Global".ball_sprint:
				run = 600
				$salsicha_collision.disabled = true
				$ball_dash_collision.disabled = false
				$AnimatedSprite2D.animation = "ball_dash"
				$mochila.visible = false
			else:
				run = 300
		else:
			$salsicha_collision.disabled = false
			$ball_dash_collision.disabled = true
			$AnimatedSprite2D.animation = current_animation
			$mochila.visible = true
			run = 0

		velocity.x = direction * (global.player_speed + run  + calango)
		
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
			$mochila.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
			$mochila.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, global.player_speed)

	move_and_slide()

func _process(delta):
	if $Power_cooldown.is_stopped() == false:
		$Cooldown_image.value = $Power_cooldown.wait_time - $Power_cooldown.time_left
	else:
		$Cooldown_image.value = 0
	
	if shield and global.gain_shield:
		$Shield.visible = true
		$Shield/CollisionShape2D.disabled = false
		shield = false

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and ammo_delay == false:
		var  bullet = preload("res://Scenes/Game/Scenes/bullet.tscn").instantiate()
		bullet.get_node("AnimatedSprite2D").play(global.bullet_type)
		bullet.global_position = Vector2(global_position.x,global_position.y-100)
		get_tree().current_scene.add_child(bullet)
		ammo_delay = true
		$Shoot_delay.start(1)
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_Q:
			if $"/root/Global".calango and power == false:
				current_animation = "calango"
				$AnimatedSprite2D.animation = current_animation
				$mochila.animation = current_animation
				scale = Vector2(0.5,0.5)
				calango = $"/root/Global".calango_veloc
				$Power_timer.start(2.0)
				power = true

			if global.power and power == false:
				var  power_bullet = preload("res://Scenes/Game/Scenes/power_bullet.tscn").instantiate()
				power_bullet.get_node("AnimatedSprite2D").play(global.power_name)
				power_bullet.global_position = Vector2(global_position.x,global_position.y-100)
				get_tree().current_scene.add_child(power_bullet)
				$Cooldown_image.visible = true
				$Cooldown_image.max_value = global.power_cooldown + 15
				$Power_cooldown.start(global.power_cooldown + 15)
				power = true
				$bark_power.play()

func player_damage(damage):
	if global.player_life > 0 and invulnerable == false:
		invulnerable_count = 0
		global.player_life -= damage

		if global.player_life <= 0:
			$dog_die.play()
			get_parent().game_over()

		var heartsConteiner = get_parent().get_node("HUD").get_node("Hearts")
		heartsConteiner.updateHearts(global.player_life)
		invulnerable = true
		$dog_hurt.play()
		$Invulnerable_timer.start(0.25)

func healing(heal_value):
	if global.player_life > global.max_player_life or global.player_life + heal_value > global.max_player_life:
		global.player_life = global.max_player_life
	else:
		global.player_life += heal_value
		
	var heartsConteiner = get_parent().get_node("HUD").get_node("Hearts")
	heartsConteiner.updateHearts(global.player_life)

func _on_invulnerable_timer_timeout():
	visible = not visible
	invulnerable_count += 1

	if invulnerable_count == 6:
		invulnerable = false
		$Invulnerable_timer.stop()
		visible = true

func _on_shoot_delay_timeout():
	ammo_delay = false

func _on_power_timer_timeout():
	scale = Vector2(1,1)
	calango = 0
	$Cooldown_image.visible = true
	$Cooldown_image.max_value = global.power_cooldown
	current_animation = "default"
	$AnimatedSprite2D.animation = current_animation
	$mochila.animation = current_animation
	$Power_cooldown.start(global.power_cooldown)

func _on_power_cooldown_timeout():
	power = false
	$Cooldown_image.visible = false
