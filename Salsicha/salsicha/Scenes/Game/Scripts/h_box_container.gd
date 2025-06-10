extends HBoxContainer

@onready var Card = preload("res://Scenes/Game/Scenes/power_card.tscn")

func create_powers():
    for i in range(3):
        var card = Card.instantiate()
        add_child(card)