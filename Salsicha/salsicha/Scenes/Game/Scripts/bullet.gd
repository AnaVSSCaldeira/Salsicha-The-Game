extends Area2D

var speed = 900
var direction := Vector2.ZERO
@onready var global = $"/root/Global"

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	look_at(mouse_position)

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemies"):
		var damage_bonus = global.bullet_damage * global.damage_bonus / 100
		area.take_damage(global.bullet_damage + damage_bonus)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
