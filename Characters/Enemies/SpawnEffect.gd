extends AnimatedSprite



func _ready() -> void:
	playing = true



func _on_SpawnEffect_animation_finished() -> void:
	queue_free()
