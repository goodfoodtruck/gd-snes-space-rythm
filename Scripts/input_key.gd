extends Sprite2D

@onready var input_sound = $InputSound

@export var fade_time: float = 0.5  # Time in seconds for the fade-out
@export var fall_distance: float = 50  # Distance to fall

var is_success = false
var key = ''


func _ready():
	var sound_key_method = ""
	match key:
		'A':
			region_rect = Rect2(0,  0, 16, 16)
			position += Vector2(16, 0)
			sound_key_method = "play_sound_a"
		'X':
			region_rect = Rect2(32, 0, 16, 16)
			position += Vector2(0, -16)
			sound_key_method = "play_sound_a"
		'B':
			region_rect = Rect2(16, 0, 16, 16)
			position += Vector2(0, 16)
			sound_key_method = "play_sound_a"
		'Y':
			region_rect = Rect2(48, 0, 16, 16)
			position += Vector2(-16, 0)
			sound_key_method = "play_sound_a"

	if !is_success:
		texture = load("res://Sprites/input_failed.png")
	else:
		input_sound.call(sound_key_method)

	# Start the effect when the scene is ready
	modulate = Color(1, 1, 1, 1)  # Make sure the sprite is fully visible
	fall_and_fade()


func fall_and_fade():
	# Animate the fall
	var fall_tween = create_tween()
	fall_tween.tween_property(self, "scale", scale - scale /2, fade_time)

	# Animate the fade-out
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate:a", 0, fade_time)
	
	# Optionally, queue free after fading
	fade_tween.tween_callback(Callable(self, "queue_free"))


func set_key(input_key: String):
	key = input_key


func set_is_success():
	is_success = true
