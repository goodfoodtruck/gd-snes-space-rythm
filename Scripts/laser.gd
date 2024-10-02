extends Area2D

class_name Laser

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body is Player:
		body.take_damage(50)
		queue_free()


func _physics_process(delta: float) -> void:
	position += Vector2(-90, 0) * delta
