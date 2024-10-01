extends AudioStreamPlayer

@onready var sound_key_a = preload("res://Sounds/SFX/ponsnes.ogg")
@onready var sound_key_x = preload("res://Sounds/SFX/chakasnes.ogg")
@onready var sound_key_y = preload("res://Sounds/SFX/patasnes.ogg")
@onready var sound_key_b = preload("res://Sounds/SFX/domsnes.ogg")

func play_sound_a():
	self.stream = sound_key_a
	self.play()

func play_sound_x():
	self.stream = sound_key_x
	self.play()
	
func play_sound_y():
	self.stream = sound_key_y
	self.play()

func play_sound_b():
	self.stream = sound_key_b
	self.play()
