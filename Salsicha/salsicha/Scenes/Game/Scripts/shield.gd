extends Area2D

@export var orbit_radius: float = 80.0
@export var orbit_speed: float = 1
var can_protect = true

var angle: float = 0.0
var player_node: Node2D

func _ready():
	player_node = get_parent()

func _process(delta):
	angle += orbit_speed * delta * TAU
	var offset = Vector2.RIGHT.rotated(angle) * orbit_radius
	global_position = player_node.global_position + offset

func _on_area_entered(area:Area2D):
	if area.is_in_group("enemy_bullet") and can_protect:
		$AnimatedSprite2D.self_modulate.a = 0.5
		can_protect = false
		area.queue_free()
		$Disabled.start(5)

func _on_disable_timeout():
	can_protect = true
	$AnimatedSprite2D.self_modulate.a = 1