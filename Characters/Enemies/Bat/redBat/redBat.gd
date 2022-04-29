extends Enemy

onready var hitbox: Area2D = get_node("Hitbox")
onready var green_collision: CollisionShape2D = get_node("CollisionShape2D")


func _ready():
#	animated_sprite_bat.visible = true
	green_collision.disabled = false
	

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
