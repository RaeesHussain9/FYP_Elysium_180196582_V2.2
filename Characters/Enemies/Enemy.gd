extends Character
class_name Enemy, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/enemies/flying creature/fly_anim_f0.png"

var path: PoolVector2Array

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Floor")

onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")

onready var path_timer: Timer = get_node("PathTimer")

onready var equipped_weapon: Node2D = get_tree().current_scene.get_node("Player/Weapons")


var normal_damage: int = 2
var crit_damage: int = 5
var weakend_damage: int = 1

func chase() -> void:
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < 3:
			path.remove(0)
			if not path:
				return
		move_direction = vector_to_next_point
		
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true


func take_damage(_dam: int, dir: Vector2, force: int) -> void:
	if player.weapons.get_child(0) == player.equipped_weapon:
		if has_node("blue") == true:
			.take_damage(weakend_damage, dir, force/3)
		elif has_node("green") == true:
			.take_damage(crit_damage, dir, force)
		elif has_node("red") == true:
			.take_damage(normal_damage, dir, force/1.5)

	elif player.weapons.get_child(1) == player.equipped_weapon:
		if has_node("blue") == true:
			.take_damage(normal_damage, dir, force/1.5)
		elif has_node("green") == true:
			.take_damage(weakend_damage, dir, force/3)
		elif has_node("red") == true:
			.take_damage(crit_damage, dir, force)

	elif player.weapons.get_child(2) == player.equipped_weapon:
		if has_node("blue") == true:
			.take_damage(crit_damage, dir, force)
		elif has_node("green") == true:
			.take_damage(normal_damage, dir, force/1.5)
		elif has_node("red") == true:
			.take_damage(weakend_damage, dir, force/3)

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_Path_To_Player()
	else:
		path_timer.stop()
		path = []
		move_direction = Vector2.ZERO


func _get_Path_To_Player() -> void:
	path = navigation.get_simple_path(global_position, player.position)
