extends Area2D

var speed
var direction := Vector2.ZERO
var damage = 10

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	look_at(mouse_position)

func _process(delta):
	speed = $"/root/Global".bullet_speed
	position += direction * speed * delta

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemies"):
		# var damage = damage + (damage * global.damage_bonus / 100)
		area.take_damage(damage)
		# queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

