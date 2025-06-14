extends Node

@export var player_life = 5
@export var bullet_type = "default"
@export var bullet_damage = 1
@export var powers_number = 3
@export var powers = {
    "1": {
        "Name": "Calanguinho", "Description": "Vire um calanguinho! Diminua de tamanho e fique mais rápido!\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": power_calango()
        }, 
    "2": {
        "Name": "Projetil saboroso", "Description": "Atire cachorros-quentos nos inimigos! São mais lentos mas dão mais dano.", "Unique": true, "Active": false, "Function": change_bullet("hotdog", 5, 300)
        }, 
    "3": {
        "Name": "Dash Bolinha", "Description": "Ao correr, você vira uma bolinha e aumenta sua velocidade.", "Unique": true, "Active": false, "Function": ball_dash()
        }, 
    "4": {
        "Name": "Aumento de velocidade", "Description": "Aumenta o valor da sua velocidade em 5%", "Unique": false, "Active": false, "Function": velocity_up(5)
        }, 
    "5": {
        "Name": "Aumento de ataque", "Description": "Aumenta o valor do seu ataque em 5%", "Unique": false, "Active": false, "Function": damage_up(5)
        }, 
    "6": {
        "Name": "Latido Super Sônico", "Description": "Dê um latido poderoso que dá um bom dano em área mas sem muito alcance.\nAperte a tecla Q para usar.\nEste poder substituirá o atual.", "Unique": true, "Active": true, "Function": super_sonic_bark()
        }
    }
var unique_powers = []
var current_ability = 0

func restart():
    player_life = 5
    bullet_type = "default"
    bullet_damage = 1
    powers_number = 3
    unique_powers = []
    current_ability = 0

func chosen_power(id):
    pass

func power_calango():
    pass

func change_bullet(bullet, damage, velocity):
    pass

func ball_dash():
    pass

func velocity_up(percentage):
    pass
    
func damage_up(percentage):
    pass

func super_sonic_bark():
    pass