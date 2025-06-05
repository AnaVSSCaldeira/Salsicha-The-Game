extends Area2D

var speed = 900

func _ready():
	pass

func _process(delta):
	position += -(transform.y) * speed * delta

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemies"):
		get_parent().handle_enemy_damage(area, $"/root/Global".bullet_damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
