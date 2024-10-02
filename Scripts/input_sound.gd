extends AudioStreamPlayer

@onready var sound_key_a_success = preload("res://Sounds/SFX/ponsnes.ogg")
@onready var sound_key_x_success = preload("res://Sounds/SFX/chakasnes.ogg")
@onready var sound_key_y_success = preload("res://Sounds/SFX/patasnes.ogg")
@onready var sound_key_b_success = preload("res://Sounds/SFX/domsnes.ogg")
@onready var sound_key_a_failed1 = preload("res://Sounds/SFX/ponfailed1.ogg")
@onready var sound_key_a_failed2 = preload("res://Sounds/SFX/ponfailed2.ogg")
@onready var sound_key_x_failed1 = preload("res://Sounds/SFX/chakafailed1.ogg")
@onready var sound_key_x_failed2 = preload("res://Sounds/SFX/chakafailed2.ogg")
@onready var sound_key_y_failed1 = preload("res://Sounds/SFX/domfailed1.ogg")
@onready var sound_key_y_failed2 = preload("res://Sounds/SFX/domfailed2.ogg")
@onready var sound_key_b_failed1 = preload("res://Sounds/SFX/patafailed1.ogg")
@onready var sound_key_b_failed2 = preload("res://Sounds/SFX/patafailed2.ogg")


# Touche "A"
func play_sound_a():
	self.stream = sound_key_a_success
	self.play()

func play_sound_a_failed():
	self.stream = sound_key_a_failed1 if randf() < 0.5 else sound_key_a_failed2
	self.play()

# Touche "X"
func play_sound_x():
	self.stream = sound_key_x_success
	self.play()
	
func play_sound_x_failed():
	self.stream = sound_key_x_failed1 if randf() < 0.5 else sound_key_x_failed2
	self.play()

# Touche "Y"
func play_sound_y():
	self.stream = sound_key_y_success
	self.play()

func play_sound_y_failed():
	self.stream = sound_key_y_failed1 if randf() < 0.5 else sound_key_y_failed2
	self.play()

# Touche "B"
func play_sound_b():
	self.stream = sound_key_b_success
	self.play()

func play_sound_b_failed():
	self.stream = sound_key_b_failed1 if randf() < 0.5 else sound_key_b_failed2
	self.play()
