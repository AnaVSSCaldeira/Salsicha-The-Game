extends Area2D

@export var orbit_radius: float = 200.0
@export var orbit_speed: float = 0.5
# @export var orbit_speed: float = 3

var angle: float = 0.0
var player_node: Node2D

func _ready():
	player_node = get_parent()

func _process(delta):
	angle += orbit_speed * delta * TAU
	var offset = Vector2.RIGHT.rotated(angle) * orbit_radius
	global_position = player_node.global_position + offset

func _on_area_exited(area:Area2D):
	if area.is_in_group("enemy_bullet"):
		area.queue_free()
