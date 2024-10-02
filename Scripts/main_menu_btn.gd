extends TextureButton

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode in [KEY_A, KEY_X, KEY_Y, KEY_B]:
			get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")

func _pressed():
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")
