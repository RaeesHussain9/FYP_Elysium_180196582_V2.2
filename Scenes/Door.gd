extends StaticBody2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready():
	pass # Replace with function body.

func open() -> void:
	animation_player.play("open")
