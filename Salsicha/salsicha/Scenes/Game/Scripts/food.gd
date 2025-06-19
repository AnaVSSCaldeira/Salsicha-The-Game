extends CharacterBody2D

@onready var heal_value = $"/root/Global".heal

func _physics_process(delta):
    velocity.y += 300 * delta
    move_and_slide()

func _on_area_2d_body_entered(body:Node2D):
    if body.is_in_group("player"):
            get_parent().get_node("Salsicha").healing(heal_value)
            queue_free()
