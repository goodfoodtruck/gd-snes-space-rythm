extends Panel

@onready var beat_timer = $BeatTimer
@onready var sub_beat_timer = $SubBeatTimer
@onready var audio = $AudioStreamPlayer
@onready var player: Player = get_parent().get_node("Player")

var last_key_pressed = ''
var queue = []

func _ready():
	audio.play()
	beat_timer.start()
	self.modulate.a = 0


func _on_beat_timer_timeout(): # S'éxécute à chaque beat
	blink()
	sub_beat_timer.start()


func _on_sub_beat_timer_timeout(): # À la fin de la période d'input valide
	sub_beat_timer.stop()
	if last_key_pressed.is_empty(): # pas d'input sur le beat
		queue.clear()
	else:
		queue.append(last_key_pressed)
		last_key_pressed = ''
	print(queue)
	check_combo()


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			handle_input('A')
		elif event.keycode == KEY_X:
			handle_input('X')
		elif event.keycode == KEY_B:
			handle_input('B')
		elif event.keycode == KEY_Y:
			handle_input('Y')


func handle_input(key: String):
	# charge la scène pour afficher l'input à l'écran
	var input_scene = load("res://Scenes/input_key.tscn")
	var input_key_instance = input_scene.instantiate()
	input_key_instance.set_key(key)

	var threshold = beat_timer.wait_time / 4
	if beat_timer.time_left <= threshold * 3 and beat_timer.time_left >= threshold:
		# input pas sur le beat
		queue.clear()
	else:
		# success
		input_key_instance.set_is_success()
		last_key_pressed = key

	# affiche la touche à l'écran
	get_parent().add_child(input_key_instance)


func blink():
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, beat_timer.wait_time / 2).set_ease(Tween.EASE_IN)
	self.modulate.a = 1


func check_combo():
	# TODO increment combo for fever
	match queue:
		['A', 'X', 'A', 'X']: player.fire_rocket(); queue.clear()
		['X', 'A', 'A', 'X']: player.activate_shield(); queue.clear()
		['A', 'A', 'A', 'X']: player.dodge_up(); queue.clear()
		['A', 'A', 'X', 'A']: player.dodge_down(); queue.clear()
	if len(queue) >= 4:
		queue.clear()
