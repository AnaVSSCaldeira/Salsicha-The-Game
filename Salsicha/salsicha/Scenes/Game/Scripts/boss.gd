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
@export var healing_1: AudioStreamWAV
var is_dying = false

var take_break = 5
var count

func setup(initial, final):
	p1 = initial
	p2 = final
	pass

func _ready():
	$Life/Life_value.text = str(int($Life.value))
	if $Boss_sounds.playing == false:
		$Boss_sounds.stream = laugh
		$Boss_sounds.play()
	$Action.start(2.5)
	$Life.visible = false

func _physics_process(delta):
	if is_dying == false:
		velocity.x = direction * veloc
		if position.x >= p2.x:
			direction = -1
		elif position.x <= p1.x:
			direction = 1
		move_and_slide()

func make_move():
	if is_dying == false:
		if randi_range(1,100) <= take_break:
			take_break = 5
			$Action.start(3)

		else:
			var chance = randi_range(1,20)

			if chance >= 1 and chance <= 13:
				if randi_range(1,4) <= 2:
					$Boss_sounds.stream = attack_2
				else:
					$Boss_sounds.stream = attack_3

				$Boss_sounds.play()
				shoot()
				
			elif (chance >= 14 and chance <= 20):
				count = 0
				$Boss_sounds.stream = attack_1
				$Boss_sounds.play()
				while count < 5:
					chocolate()
					$ChocoAttack.start(1)
					await $ChocoAttack.timeout
					count += 1

			$Action.start(2)

			if $Life.value < $Life.max_value:
				if randi_range(1,100) <= 40:
					$Boss_sounds.stream = healing_1
					$Boss_sounds.play()
					healing()
				$Action.start(2)

			take_break += 5	

func healing():
	var cure = randi_range(1,10)
	if cure + $Life.value >= $Life.max_value:
		$Life.value = $Life.max_value
	else:
		$Life.value += cure

func _on_action_timeout():
	if is_dying == false:
		make_move()

func take_damage(damage):
	if is_dying == false:
		if $Life.value <= 0 or $Life.value - damage <= 0:
			is_dying = true
			$Boss_sounds.stream = die
			$Boss_sounds.play()

		$Life.visible = true

		if randi_range(1,100) <= 50:
			if $Boss_sounds.playing == false:
				$Boss_sounds.stream = damage_1
				$Boss_sounds.play()

		$Life.value = $Life.value - damage

		$Life/Life_value.text =  str(int($Life.value))

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

		var food_type = randi_range(1,100)

		if food_type >= 1 and food_type <= 80:
			food_name = "chocolate"
		elif food_type >= 81 and food_type <= 86:
			food_name = "maca"
		elif food_type >= 87 and food_type <= 95:
			food_name = "carne"
		else:
			food_name = "cenoura"

		food.setup(food_name)
		
		food.get_node("AnimatedSprite2D").animation = food_name
		food.global_position = Vector2(global_position.x,global_position.y+150)
		
		get_tree().current_scene.add_child(food)

func _on_boss_sounds_finished():
	if $Boss_sounds.stream == die:
		queue_free()
