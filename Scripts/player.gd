extends Entity

class_name Player

signal health_changed

@onready var shield_sound = $ShieldSound
@onready var damage_sound = $DamageSound
@onready var rocket_sound = $RocketSound
@onready var dodge_sound  = $DodgeSound

var initial_position = position
var queue = []


func fire_rocket() -> void:
	var rocket_scene = preload("res://Scenes/rocket.tscn")
	var rocket = rocket_scene.instantiate()
	rocket.position = position
	get_parent().add_child(rocket)
	rocket_sound.play()


func activate_shield():
	has_shield = true
	await get_tree().create_timer(2.0).timeout
	has_shield = false
	shield_sound.play()

func take_damage(damage: int) -> void:
	super(damage)
	health_changed.emit()
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	damage_sound.play()

func dodge_up() -> void:
	position = initial_position + Vector2(0, -60)
	await get_tree().create_timer(2.0).timeout
	position = initial_position
	dodge_sound.play()


func dodge_down() -> void:
	position = initial_position + Vector2(0, 60)
	await get_tree().create_timer(2.0).timeout
	position = initial_position
	dodge_sound.play()
