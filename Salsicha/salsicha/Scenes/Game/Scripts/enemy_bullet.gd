extends Area2D

var speed = 500
var direction := Vector2.ZERO
var bullet_damage

func _ready():
	var player_position = (get_parent().get_node("Salsicha")).global_position
	direction = (player_position - global_position).normalized()
	look_at(player_position)

func _process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body:Node2D):
	if body.is_in_group("player"):
		get_parent().get_node("Salsicha").player_damage(bullet_damage)
		queue_free()

func setup(bullet_type):
	match bullet_type:
		"default":
			bullet_damage = 1
		"strong":
			bullet_damage = 3