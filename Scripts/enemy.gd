extends Entity

class_name Enemy

@onready var enemy_timer = $EnemyTimer
@onready var damage_sound = $DamageSound
@onready var charge_sound = $ChargeSound

func _ready() -> void:
	enemy_timer.start()


func take_damage(damage: int) -> void:
	super(damage)
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/menu_win.tscn")
	damage_sound.play()


func _on_enemy_timer_timeout() -> void:
	if randf() < 0.1:
		shockwave()
	else:
		charging_anim()
		await get_tree().create_timer(2).timeout
		shoot_laser()
		if randf() < 0.5:
			if randf() < 0.5:
				shoot_laser(position + Vector2(0, -60))
			else:
				shoot_laser(position + Vector2(0, 60))


func shockwave():
	for i in range(7):
		modulate = Color(1, 0, 0)
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 0, 1)
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 1, 1)
		await get_tree().create_timer(0.1).timeout
	
	charging_anim()
	await get_tree().create_timer(2).timeout
	shoot_laser(position + Vector2(0, -60))
	shoot_laser()
	shoot_laser(position + Vector2(0, 60))


func shoot_laser(laser_position=position):
	var laser_scene = preload("res://Scenes/laser.tscn")
	var laser = laser_scene.instantiate()
	laser.position = laser_position
	get_parent().add_child(laser)


func charging_anim():
	charge_sound.play()
	for i in range(7):
		position.x += 2
		await get_tree().create_timer(0.1).timeout
		position.x -= 2
		await get_tree().create_timer(0.1).timeout
