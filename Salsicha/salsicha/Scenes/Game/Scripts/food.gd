extends CharacterBody2D

@onready var heal_value = $"/root/Global".heal
@export var auto_destroy = false
@export var deal_damage = false
@export var player_in_area = false

func _ready():
    if auto_destroy:
        $Timer.start(5)

func _physics_process(delta):
    velocity.y += 300 * delta
    move_and_slide()

func _on_area_2d_body_entered(body:Node2D):
    if body.is_in_group("player"):
        if deal_damage:
            get_parent().get_node("Salsicha").player_damage(1)
            player_in_area = true
            $Damage.start(0.5)
        else:
            get_parent().get_node("Salsicha").healing(heal_value)
            queue_free()

func setup(food):
    auto_destroy = true
    if food == "chocolate":
        deal_damage = true

func _on_timer_timeout():
    queue_free()

func _on_damage_timeout():
    if player_in_area:
        get_parent().get_node("Salsicha").player_damage(1)

func _on_area_2d_body_exited(body:Node2D):
    player_in_area = false
