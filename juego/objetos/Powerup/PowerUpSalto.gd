extends "res://juego/objetos/Powerup/PowerUpBase.gd"

func aplicar_power_up(body):
	body.cambiar_fuerza_salto()
