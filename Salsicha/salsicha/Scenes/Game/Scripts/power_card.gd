extends Panel

@export var id: int
@export var rarity: String

signal button_pressed(id, rarity)

@onready var button = $Button

func _ready():
	button.pressed.connect(_on_pressed)

func _on_pressed():
	emit_signal("button_pressed", id, rarity)
