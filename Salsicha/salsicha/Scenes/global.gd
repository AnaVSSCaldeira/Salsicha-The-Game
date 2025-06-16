extends Node

@export var player_life = 5
@export var bullet_type = "default"
@export var bullet_damage = 1
@export var powers_number = 3
@export var powers = {
	"1": {
		"Name": "Calanguinho", "Description": "Vire um calanguinho! Diminua de tamanho e fique mais rápido!\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": "power_calango", "Params": []
		}, 
	"2": {
		"Name": "Projetil saboroso", "Description": "Atire cachorros-quentos nos inimigos! São mais lentos mas dão mais dano.", "Unique": true, "Active": false, "Function": "change_bullet", "Params": ["hotdog", 5, 300]
		}, 
	"3": {
		"Name": "Dash Bolinha", "Description": "Ao correr, você vira uma bolinha e aumenta sua velocidade.", "Unique": true, "Active": false, "Function": "ball_dash", "Params": []
		}, 
	"4": {
		"Name": "Aumento de velocidade", "Description": "Aumenta o valor da sua velocidade em 5%", "Unique": false, "Active": false, "Function": "velocity_up", "Params": [5]
		}, 
	"5": {
		"Name": "Aumento de ataque", "Description": "Aumenta o valor do seu ataque em 5%", "Unique": false, "Active": false, "Function": "damage_up", "Params": [5]
		}, 
	"6": {
		"Name": "Latido Super Sônico", "Description": "Dê um latido poderoso que dá um bom dano em área mas sem muito alcance.\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": "super_sonic_bark", "Params": []
		}
	}
var unique_powers = []
var current_ability = 0
var velocity_bonus = 0
var damage_bonus = 0.0

func restart():
	player_life = 5
	bullet_type = "default"
	bullet_damage = 1
	powers_number = 3
	unique_powers = []
	current_ability = 0
	velocity_bonus = 0
	damage_bonus = 0

#aqui ele verifica se é unico ou nao para adicionar na lista e tambem verifica se é uma habilidade ativa para ser a habilidade atual
func chosen_power(id):
	print("Poder escolhido:", id)

func power_calango():
	print("oi!!!")

func change_bullet(bullet, damage, velocity):
	print("oi!!!")

func ball_dash():
	print("oi!!!")

func velocity_up(percentage):
	velocity_bonus = velocity_bonus + percentage
	
func damage_up(percentage):
	damage_bonus = damage_bonus + percentage

func super_sonic_bark():
	print("oi!!!")
