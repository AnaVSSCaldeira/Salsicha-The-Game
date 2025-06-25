extends HBoxContainer

@onready var Life = preload("res://Scenes/Game/Scenes/Life.tscn")

func setMaxHearts(max : int):
	for i in range(max):
		var heart = Life.instantiate()
		heart.get_node("Heart").animation = "full"
		add_child(heart)

func addMoreHearts(max : int):
	for i in range(max):
		var heart = Life.instantiate()
		heart.get_node("Heart").animation = "empty"
		add_child(heart)

func updateHearts(currentHealth : int):
	var hearts = get_children()

	for i in range(currentHealth):
		hearts[i].get_node("Heart").animation = "full"
	
	for i in range(currentHealth, hearts.size()):
		hearts[i].get_node("Heart").animation = "empty"
