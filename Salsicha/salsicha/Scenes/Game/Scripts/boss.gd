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

func setup(initial, final):
	p1 = initial
	p2 = final
	pass

func _ready():
	$Boss_sounds.stream = laugh
	$Boss_sounds.play()
	$Action.start(2.5)

func _physics_process(delta):
	velocity.x = direction * veloc
	if position.x >= p2.x:
		direction = -1
	elif position.x <= p1.x:
		direction = 1
	move_and_slide()

func make_move():
	if randi_range(1,100) <= take_break:
		$Action.start(3)
	else:
		var chance = randi_range(1,15)
		if chance >= 1 and chance <= 5:
			pass
		elif chance >= 6 and chance <= 10:
			pass
		else:
			pass	

func _on_action_timeout():
	make_move()

func take_damage(damage):
	if randi_range(1,100) == 50:
		$Boss_sounds.stream = damage_1
		$Boss_sounds.play()

	if $Life.value == $Life.max_value:
		$Life.visible = true

	$Life.value = $Life.value - damage