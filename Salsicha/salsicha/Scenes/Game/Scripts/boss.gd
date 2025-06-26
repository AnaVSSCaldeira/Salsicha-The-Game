extends CharacterBody2D

@export var veloc = 400
@export var direction = 1
@export var p1: Vector2
@export var p2: Vector2
@export var die: AudioStreamWAV
@export var laugh: AudioStreamWAV
@export var attack_1: AudioStreamWAV
@export var attack_2: AudioStreamWAV
@export var attack_3: AudioStreamWAV
@export var damage_1: AudioStreamWAV

var take_break = 10
var count

func setup(initial, final):
	p1 = initial
	p2 = final
	pass

func _ready():
	if $Boss_sounds.playing == false:
		$Boss_sounds.stream = laugh
		$Boss_sounds.play()
	$Action.start(2.5)
	$Life.visible = false

func _physics_process(delta):
	velocity.x = direction * veloc
	if position.x >= p2.x:
		direction = -1
	elif position.x <= p1.x:
		direction = 1
	move_and_slide()

func make_move():
	if randi_range(1,100) <= take_break:
		take_break = 10
		$Action.start(3)

	else:
		var chance = randi_range(1,15)

		if chance >= 1 and chance <= 8:
			if randi_range(1,4) <= 2:
				if $Boss_sounds.playing == false:
					$Boss_sounds.stream = attack_2
			else:
				if $Boss_sounds.playing == false:
					$Boss_sounds.stream = attack_3

				$Boss_sounds.play()
			shoot()
			
		elif (chance >= 9 and chance <= 15):
			count = 0
			if $Boss_sounds.playing == false:
				$Boss_sounds.stream = attack_1
				$Boss_sounds.play()
			while count < 3:
				chocolate()
				$ChocoAttack.start(1)
				await $ChocoAttack.timeout
				count += 1

		$Action.start(2)

		if $Life.value < $Life.max_value:
			if randi_range(1,100) <= 50:
				pass
			$Action.start(2)

		take_break += 10	

func _on_action_timeout():
	make_move()

func take_damage(damage):
	if $Life.value <= 0:
		queue_free()

	if $Life.value == $Life.max_value:
		$Life.visible = true

	if randi_range(1,100) <= 50:
		if $Boss_sounds.playing == false:
			$Boss_sounds.stream = damage_1
			$Boss_sounds.play()

	$Life.value = $Life.value - damage

	spawn_food(false)

func shoot():
	var  bullet = preload("res://Scenes/Game/Scenes/enemy_bullet.tscn").instantiate()
	bullet.setup("boss")
	bullet.global_position = Vector2(global_position.x,global_position.y+100)
	get_tree().current_scene.add_child(bullet)

func chocolate():
	spawn_food(true)

func spawn_food(damage):

	var spawn_food = randi_range(1,100)
	if spawn_food <= 40 or damage:
		var food = preload("res://Scenes/Game/Scenes/food.tscn").instantiate()
		var food_name

		if damage:
			food_name = "chocolate"

		else:
			var food_type = randi_range(1,15)

			if food_type >= 1 and food_type <= 5:
				food_name = "maca"
			elif food_type >= 6 and food_type <= 10:
				food_name = "carne"
			else:
				food_name = "cenoura"

		food.setup(food_name)
		
		food.get_node("AnimatedSprite2D").animation = food_name
		food.global_position = Vector2(global_position.x,global_position.y+150)
		
		get_tree().current_scene.add_child(food)