extends HBoxContainer

@onready var Card = preload("res://Scenes/Game/Scenes/power_card.tscn")

func create_powers():
	var all_powers_list = $"/root/Global".powers
	var powers_list = []
	var unique_powers = $"/root/Global".unique_powers

	for i in range(3):
		var card = Card.instantiate()
		var power = randi_range(1,6)
		while power in powers_list or power in unique_powers:
			power = randi_range(1,6)

		powers_list.append(power)
		card.get_node("Control").get_node("Name").text = all_powers_list[str(power)]["Name"]
		card.get_node("Control").get_node("Description").text = all_powers_list[str(power)]["Description"]
		card.id = power
		
		add_child(card)

func destroy_powers():
	for child in get_children():
		remove_child(child)
		child.queue_free()