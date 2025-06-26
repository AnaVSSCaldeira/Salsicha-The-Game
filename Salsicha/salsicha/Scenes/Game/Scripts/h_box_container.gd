extends HBoxContainer

@onready var Card = preload("res://Scenes/Game/Scenes/power_card.tscn")

func create_powers():
	var all_powers_list = $"/root/Global".powers
	var powers_list = []
	var unique_powers = $"/root/Global".unique_powers

	for i in range(3):
		var rarity = randi_range(1,100) #para saber a raridade
		var powers_by_rarity #para saber a lista de poderes a partir da raridade
		var range #para saber quantas cartas tem para procurar

		var card = Card.instantiate()

		if rarity >= 1 and rarity <= 50:
			powers_by_rarity = all_powers_list["Common"]
			range = 0
			card.rarity = "Common"
		
		elif rarity >= 51 and rarity <= 80:
			powers_by_rarity = all_powers_list["Uncommon"]
			range = 100
			card.rarity = "Uncommon"
		else:
			powers_by_rarity = all_powers_list["Rare"]
			range = 200
			card.rarity = "Rare"

		var power = randi_range((range + 1), (range + powers_by_rarity.size()))
		while power in powers_list or power in unique_powers:
			power = randi_range((range + 1),(range + powers_by_rarity.size()))

		powers_list.append(power)
		card.get_node("Control").get_node("Name").text = powers_by_rarity[str(power)]["Name"]
		card.get_node("Control").get_node("Description").text = powers_by_rarity[str(power)]["Description"]
		card.get_node("AnimatedSprite2D").animation = card.rarity
		card.get_node("Control").get_node("PowerImage").animation = str(power)
		card.id = power
		
		# para debug
		# card.id = 108
		# card.rarity = "Uncommon"
		
		add_child(card)

func destroy_powers():
	for child in get_children():
		remove_child(child)
		child.queue_free()
