extends Panel

@onready var beat_timer = $BeatTimer
@onready var sub_beat_timer = $SubBeatTimer
@onready var music_player = $MusicPlayer
@onready var player: Player = get_parent().get_node("Player")

var last_key_pressed = ''
var queue = []
var combo_count = 120 # On donne volontairement une valeur impossible pour le début
var need_music_switch = false
var music: AudioStreamPlaybackInteractive

func _ready():
	music_player.play()
	music = music_player.get_stream_playback()
	beat_timer.start()
	self.modulate.a = 0


func _on_beat_timer_timeout(): # S'éxécute à chaque beat
	$Label.text = str(combo_count) if combo_count != 120 else "0"
	blink()
	sub_beat_timer.start()
	if need_music_switch:
		switch_music_clip()


func _on_sub_beat_timer_timeout(): # À la fin de la période d'input valide
	sub_beat_timer.stop()
	if last_key_pressed.is_empty(): # pas d'input sur le beat
		queue.clear()
	else:
		queue.append(last_key_pressed)
		last_key_pressed = ''
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
		reset_or_increment_combo(false)
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
	var combo_actions = {
		['A', 'X', 'A', 'X']: player.fire_rocket,
		['X', 'A', 'A', 'X']: player.activate_shield,
		['A', 'A', 'A', 'X']: player.dodge_up,
		['A', 'A', 'X', 'A']: player.dodge_down
	}
	
	if queue in combo_actions:
		combo_actions[queue].call()
		queue.clear()
		reset_or_increment_combo(true)

	if len(queue) >= 4:
		queue.clear()


func reset_or_increment_combo(increment: bool):
	if increment:
		combo_count = 1 if combo_count == 120 else combo_count + 1
	else:
		combo_count = 0
	
	if combo_count in [0, 1, 3, 5, 7]:
		need_music_switch = true


func switch_music_clip():
	need_music_switch = false
	var clips = {
		0: "Tempo",
		1: "Niveau1",
		3: "Niveau2",
		5: "Niveau3",
		7: "Niveau4"
	}
	if combo_count in clips:
		music.switch_to_clip_by_name(clips[combo_count])
