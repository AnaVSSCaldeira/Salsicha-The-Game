extends HBoxContainer

@onready var Life = preload("res://Scenes/Game/Scenes/Life.tscn")

func _ready():
	pass

func _process(delta):
	pass

func setMaxHearts(max : int):
	for i in range(max):
		var heart = Life.instantiate()
		add_child(heart)

func updateHearts(currentHealth : int):
	var hearts = get_children()

	for i in range(currentHealth):
		hearts[i].update(true)
	
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
