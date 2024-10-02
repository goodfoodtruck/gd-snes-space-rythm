extends CharacterBody2D

class_name Entity

var max_health: int = 1000
var health: int = 1000
var has_shield: bool = false


func take_damage(damage: int):
	if !has_shield:
		health -= damage
	else:
		health -= damage / 2
