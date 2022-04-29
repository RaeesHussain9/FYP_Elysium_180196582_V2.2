extends Enemy

const max_Distance_To_Player: int = 80
const min_Distance_To_Player: int = 40
const Throwing_Knife_Scene: PackedScene = preload("res://Characters/Enemies/Gremlin/ThrowingKnife.tscn")

const Throwing_Knife_2_Scene: PackedScene = preload("res://Characters/Enemies/Gremlin/ThrowingKnife2.tscn")

var distance_to_player: float 

export(int) var projectile_velocity: int = 150

var can_attack: bool = true

onready var attack_timer: Timer = get_node("AttackTimer")
onready var aim_rayCast: RayCast2D = get_node("AimRayCast")

func _ready():
	pass 

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player > max_Distance_To_Player:
			_get_Path_To_Player()
		elif distance_to_player < min_Distance_To_Player:
			_get_Retreat_Path_From_Player()
		else:
			aim_rayCast.cast_to = player.position - global_position
			if can_attack and state_machine.state == state_machine.states.idle and not aim_rayCast.is_colliding():
				can_attack = false
				_throw_knife()
				attack_timer.start()
	else:
		path_timer.stop()
		path = []
		move_direction = Vector2.ZERO

func _get_Retreat_Path_From_Player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	path = navigation.get_simple_path(global_position, global_position + dir * 100)
	
	
func _throw_knife() -> void:
	var projectile: Area2D = Throwing_Knife_Scene.instance()
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_velocity)
	get_tree().current_scene.add_child(projectile)

func _on_AttackTimer_timeout() -> void:
	can_attack = true
