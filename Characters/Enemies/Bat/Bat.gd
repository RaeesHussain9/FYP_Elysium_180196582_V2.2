extends Enemy

onready var hitbox: Area2D = get_node("Hitbox")

#func _ready():
#	animated_sprite_bat.visible = true
#	pass

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
