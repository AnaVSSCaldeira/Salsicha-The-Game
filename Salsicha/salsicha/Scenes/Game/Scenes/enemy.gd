extends Area2D

var life = 3

func _ready():
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