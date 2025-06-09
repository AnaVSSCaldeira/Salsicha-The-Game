extends Node

@export var player_life: int
@export var bullet_type: String
@export var bullet_damage: int
@export var powers_number: int
@export var powers = {"1": {"Name": "Calanguinho", "Description": "Vire um calanguinho! Diminua de tamanho e fique mais rápido!\nAperte a tecla Q para usar.\nEste poder substituirá o atual."}, "2": {"Name": "Projetil saboroso", "Description": "Atire cachorros-quentos nos inimigos! São mais lentos mas dão mais dano."}, "3": {"Name": "Dash Bolinha", "Description": "Ao correr, você vira uma bolinha e aumenta sua velocidade."}, "4": {"Name": "Aumento de velocidade", "Description": "Aumenta o valor da sua velocidade em 5%"}, "5": {"Name": "Aumento de ataque", "Description": "Aumenta o valor do seu ataque em 5%"}, "6": {"Name": "Latido Super Sônico", "Description": "Dê um latido poderoso que dá um bom dano em área mas sem muito alcance.\nAperte a tecla Q para usar.\nEste poder substituirá o atual."}}

func restart():
    player_life = 5
    bullet_type = "default"
    bullet_damage = 1
    powers_number = 3