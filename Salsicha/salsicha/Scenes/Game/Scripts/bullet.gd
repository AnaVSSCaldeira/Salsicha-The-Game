extends Area2D

var speed
var direction := Vector2.ZERO
var damage = 0.0
@onready var global = $"/root/Global"

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	look_at(mouse_position)
	damage = global.bullet_damage

func _process(delta):
	speed = $"/root/Global".bullet_speed
	position += direction * speed * delta

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemies"):
		area.take_damage(damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free()
