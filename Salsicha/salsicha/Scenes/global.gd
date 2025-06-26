extends Node

@export var player_jump = -500
@export var player_life = 5
@export var player_life_change = false
@export var max_player_life = 5
@export var bullet_type = "default"
@export var bullet_damage = 2.0
@export var bullet_speed = 700.0
@export var player_speed = 300.0
@export var powers_number = 3
@export var spawn_life = 50
@export var heal = 1
@export var powers = {
	"Common":{
		"1": {
			"Name": "Projetil saboroso", "Description": "Atire cachorros-quentos nos inimigos! São mais lentos mas dão mais dano.", "Unique": true, "Active": false, "Function": "change_bullet", "Params": ["hotdog", 3, 300]
			}, 
		"2": {
			"Name": "Dash Bolinha", "Description": "Ao correr, você vira uma bolinha e aumenta sua velocidade.", "Unique": true, "Active": false, "Function": "ball_dash", "Params": []
			}, 
		"3": {
			"Name": "Vruum", "Description": "Aumenta o valor da sua velocidade em 5%.", "Unique": false, "Active": false, "Function": "velocity_up", "Params": [5.0]
			}, 
		"4": {
			"Name": "To forti", "Description": "Aumenta o valor do seu ataque em 5%.", "Unique": false, "Active": false, "Function": "damage_up", "Params": [5.0]
			}, 
		"5": {
			"Name": "Oba comida!", "Description": "Aumenta a chance de aparecer vida em 10%.", "Unique": false, "Active": false, "Function": "chance_heal_up", "Params": [10.0]
			}
			, 
		"6": {
			"Name": "Ao infinito e além", "Description": "Você pula mais alto.", "Unique": true, "Active": false, "Function": "super_jump", "Params": [300]
			}, 
		"7": {
			"Name": "Atirador iniciante", "Description": "Aumenta a velocidade da sua bala em 5%.", "Unique": false, "Active": false, "Function": "bullet_velocity_up", "Params": [5.0]
			}
	},
	"Uncommon":{
		"101": {
			"Name": "Eu sou a velocidade", "Description": "Aumenta o valor da sua velocidade em 20%.", "Unique": false, "Active": false, "Function": "velocity_up", "Params": [20.0]
			}, 
		"102": {
			"Name": "To muito forti", "Description": "Aumenta o valor do seu ataque em 20%.", "Unique": false, "Active": false, "Function": "damage_up", "Params": [20.0]
			},
		"103": {
			"Name": "Calanguinho", "Description": "Vire um calanguinho! Diminua de tamanho e fique mais rápido!\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": false, "Function": "power_calango", "Params": []
			}, 
		"104": {
			"Name": "Oba mais comida!", "Description": "Aumenta a chance de aparecer vida em 30%.", "Unique": false, "Active": false, "Function": "chance_heal_up", "Params": [30.0]
			}, 
		"105": {
			"Name": "De novo!", "Description": "Concede um pilo duplo.", "Unique": true, "Active": false, "Function": "double_jump", "Params": []
			},
		"106": {
			"Name": "Atirador mediano", "Description": "Aumenta a velocidade da sua bala em 20%.", "Unique": false, "Active": false, "Function": "bullet_velocity_up", "Params": [20.0]
			},
		"107": {
			"Name": "Duro de roer", "Description": "Atire ossos nos inimigos! São mais rápidos e um pouco mais forte.", "Unique": true, "Active": false, "Function": "change_bullet", "Params": ["bone", 2, 900]
			},
		"108": {
			"Name": "Protegido", "Description": "Invoca um escudo rotatório que te protege.", "Unique": true, "Active": false, "Function": "shield", "Params": []
			}
	},
	"Rare":{
		"201": {
			"Name": "Nem a luz me alcança", "Description": "Aumenta o valor da sua velocidade em 50%.", "Unique": false, "Active": false, "Function": "velocity_up", "Params": [50.0]
			}, 
		"202": {
			"Name": "To bombado", "Description": "Aumenta o valor do seu ataque em 50%.", "Unique": false, "Active": false, "Function": "damage_up", "Params": [50.0]
			},
		"203": {
			"Name": "Latido Super Sônico", "Description": "Dê um latido poderoso que dá um bom dano em área.\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": "super_sonic_bark", "Params": []
			},
		"204": {
			"Name": "Hum! Comida boa", "Description": "Receba mais uma vida das comidas.", "Unique": false, "Active": false, "Function": "healing_up", "Params": [1]
			},
		"205": {
			"Name": "Mais S2", "Description": "Aumenta o valor da sua vida máxima em um.", "Unique": false, "Active": false, "Function": "add_heart", "Params": [1]
			},
		"206": {
			"Name": "Atirador de elite", "Description": "Aumenta a velocidade da sua bala em 50%.", "Unique": false, "Active": false, "Function": "bullet_velocity_up", "Params": [50.0]
			}
	}
	}
@export var unique_powers = []
@export var current_ability = 0
@export var velocity_bonus = 0.0
@export var damage_bonus = 0.0
@export var ball_sprint = false
@export var calango = false
@export var calango_veloc = 0
@export var power = false
@export var power_name = ""
@export var power_cooldown = 15
@export var can_double_jump = false
@export var bullet_velocity_bonus = 0.0
@export var gain_shield = false

func restart():
	player_jump = -500
	player_life = 5
	player_life_change = false
	bullet_type = "default"
	bullet_damage = 1
	bullet_speed = 700
	powers_number = 3
	unique_powers = []
	current_ability = 0
	velocity_bonus = 0.0
	bullet_velocity_bonus = 0.0
	damage_bonus = 0.0
	ball_sprint = false
	calango = false
	calango_veloc = 0
	power = false
	power_name = ""
	player_speed = 300.0
	spawn_life = 50
	heal = 1
	max_player_life = 5
	power_cooldown = 15
	can_double_jump = false
	gain_shield = false

#aqui ele verifica se é unico ou nao para adicionar na lista e tambem verifica se é uma habilidade ativa para ser a habilidade atual
func chosen_power(id, rarity):
	if !(id in unique_powers) and powers[rarity][str(id)]["Unique"] == true:
		unique_powers.append(id)

	if powers[rarity][str(id)]["Active"] == true:
		if current_ability != 0 and current_ability in unique_powers:
			unique_powers.erase(current_ability)
		current_ability = id

func power_calango():
	calango = true
	calango_veloc = 300

func change_bullet(bullet, damage, velocity):
	bullet_type = bullet
	bullet_damage = damage + (damage * damage_bonus/100)
	bullet_speed = bullet_speed + (velocity * bullet_velocity_bonus/100)

func ball_dash():
	ball_sprint = true

func velocity_up(percentage):
	player_speed += (player_speed * percentage/100)
	velocity_bonus = velocity_bonus + percentage
	
func damage_up(percentage):
	bullet_damage += (bullet_damage * percentage/100)
	damage_bonus = damage_bonus + percentage

func super_sonic_bark():
	power = true
	power_name = "bark"

func chance_heal_up(chance):
	spawn_life += chance

func healing_up(heal_value):
	heal += heal_value

func add_heart(heart):
	max_player_life += heart
	player_life_change = true

func super_jump(value):
	player_jump -= value

func double_jump():
	can_double_jump = true

func bullet_velocity_up(percentage):
	bullet_speed += (bullet_speed * percentage/100)
	bullet_velocity_bonus += percentage

func shield():
	gain_shield = true