extends Area2D

var speed = 900
var direction := Vector2.ZERO

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	look_at(mouse_position)

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemies"):
		area.take_damage($"/root/Global".bullet_damage)
		# get_parent().handle_enemy_damage(area, $"/root/Global".bullet_damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
