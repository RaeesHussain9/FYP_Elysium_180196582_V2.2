extends CanvasLayer

const min_health: int = 0

var max_hp: int = 4

onready var player: KinematicBody2D = get_parent().get_node("Player")

onready var health_bar: TextureProgress = get_node("HealthBar")
onready var health_bar_tween: Tween = get_node("HealthBar/Tween")

func _ready():
	max_hp = player.hp
	_update_health_bar(100)

func _update_health_bar(new_val: int) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value, new_val, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()


func _on_Player_hp_changed(new_hp: int) -> void:
	var new_health: int = int((100 - min_health) * float(new_hp) / max_hp) + min_health
	_update_health_bar(new_health)
