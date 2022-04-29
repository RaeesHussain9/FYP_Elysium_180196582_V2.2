extends Node2D
class_name Weapon, "res://Art/RedSword3.png"

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox: Area2D = get_node("Node2D/Sprite/Hitbox")
onready var weapon_collision: CollisionShape2D = get_node("Node2D/Sprite/Hitbox/CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_collision.disabled = true
	

func get_input() -> void:
	if Input.is_action_just_pressed("ui_attack") and not animation_player.is_playing():
		animation_player.play("attack")


func moveMouse(mouse_direction: Vector2) -> void:
	if not animation_player.is_playing():
		rotation = mouse_direction.angle()
		hitbox.knockback_direction = mouse_direction
		if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1
		elif scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1

func is_busy() -> bool:
	if animation_player.is_playing():
		return true
	return false
