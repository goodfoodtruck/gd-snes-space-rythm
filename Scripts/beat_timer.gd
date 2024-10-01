extends Timer

@onready var sub_beat_timer = get_parent().get_node("SubBeatTimer")

@export var bpm: int = 110

func _ready() -> void:
	# On synchronise le timer avec le bpm
	self.wait_time = 60.0 / bpm
	
	# SubBeatTimer configuration
	sub_beat_timer.wait_time = self.wait_time / 4
