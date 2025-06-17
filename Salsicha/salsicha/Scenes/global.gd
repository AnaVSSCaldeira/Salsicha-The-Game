extends Node

@export var player_life = 5
@export var bullet_type = "default"
@export var bullet_damage = 1.0
@export var bullet_speed = 900.0
@export var player_speed = 300.0
@export var powers_number = 3
@export var powers = {
	"1": {
		"Name": "Calanguinho", "Description": "Vire um calanguinho! Diminua de tamanho e fique mais rápido!\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": false, "Function": "power_calango", "Params": []
		}, 
	"2": {
		"Name": "Projetil saboroso", "Description": "Atire cachorros-quentos nos inimigos! São mais lentos mas dão mais dano.", "Unique": true, "Active": false, "Function": "change_bullet", "Params": ["hotdog", 3, 300]
		}, 
	"3": {
		"Name": "Dash Bolinha", "Description": "Ao correr, você vira uma bolinha e aumenta sua velocidade.", "Unique": true, "Active": false, "Function": "ball_dash", "Params": []
		}, 
	"4": {
		"Name": "Aumento de velocidade", "Description": "Aumenta o valor da sua velocidade em 5%", "Unique": false, "Active": false, "Function": "velocity_up", "Params": [5.0]
		}, 
	"5": {
		"Name": "Aumento de ataque", "Description": "Aumenta o valor do seu ataque em 5%", "Unique": false, "Active": false, "Function": "damage_up", "Params": [5.0]
		}, 
	"6": {
		"Name": "Latido Super Sônico", "Description": "Dê um latido poderoso que dá um bom dano em área.\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": "super_sonic_bark", "Params": []
		}
	}
var unique_powers = []
var current_ability = 0
var velocity_bonus = 0.0
var damage_bonus = 0.0
var ball_sprint = false
var calango = false
var calango_veloc = 0
var power = false
var power_name = ""

func restart():
	player_life = 5
	bullet_type = "default"
	bullet_damage = 1
	bullet_speed = 900
	powers_number = 3
	unique_powers = []
	current_ability = 0
	velocity_bonus = 0.0
	damage_bonus = 0.0
	ball_sprint = false
	calango = false
	calango_veloc = 0
	power = false
	power_name = ""
	player_speed = 300.0

#aqui ele verifica se é unico ou nao para adicionar na lista e tambem verifica se é uma habilidade ativa para ser a habilidade atual
func chosen_power(id):
	if !(id in unique_powers) and powers[str(id)]["Unique"] == true:
		unique_powers.append(id)

	if powers[str(id)]["Active"] == true:
		current_ability = id
		if id in unique_powers:
			unique_powers.erase(id)

func power_calango():
	calango = true
	calango_veloc = 300

func change_bullet(bullet, damage, velocity):
	bullet_type = bullet
	bullet_damage = damage + (damage * damage_bonus/100)
	bullet_speed = velocity

func ball_dash():
	ball_sprint = true

func velocity_up(percentage):
	player_speed +=  (player_speed * percentage/100)
	velocity_bonus = velocity_bonus + percentage
	
func damage_up(percentage):
	bullet_damage += (bullet_damage * percentage/100)
	damage_bonus = damage_bonus + percentage

func super_sonic_bark():
	power = true
	power_name = "bark"
