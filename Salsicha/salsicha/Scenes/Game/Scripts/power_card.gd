extends Panel

@export var id: int
signal button_pressed(id)
@onready var button = $Button

func _ready():
    button.pressed.connect(_on_pressed)

func _on_pressed():
    emit_signal("button_pressed", id)
