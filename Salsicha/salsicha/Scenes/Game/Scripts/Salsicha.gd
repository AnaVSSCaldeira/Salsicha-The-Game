extends CharacterBody2D

const JUMP_VELOCITY = -500.0

@onready var global = $"/root/Global"

var run
var invulnerable = false
var invulnerable_count
var ammo_delay = false
var power = false
var calango

func _ready():
	$ball_dash_collision.disabled = true
	$AnimatedSprite2D.animation = "default"
	$mochila.visible = true
	scale = Vector2(1,1)
	calango = 0
	power = false

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$dog_jump.play()

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
			$AnimatedSprite2D.animation = "default"
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
				scale = Vector2(0.5,0.5)
				calango = $"/root/Global".calango_veloc
				$Power_timer.start(2.0)
				power = true

			if global.power and power == false:
				var  power_bullet = preload("res://Scenes/Game/Scenes/power_bullet.tscn").instantiate()
				power_bullet.get_node("AnimatedSprite2D").play(global.power_name)
				power_bullet.global_position = Vector2(global_position.x,global_position.y-100)
				get_tree().current_scene.add_child(power_bullet)
				$Power_cooldown.start(300)
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
	if global.player_life > global.max_player_life or global.player_life + heal_value > 5:
		global.player_life = 5
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
	$Power_cooldown.start(150)

func _on_power_cooldown_timeout():
	power = false
