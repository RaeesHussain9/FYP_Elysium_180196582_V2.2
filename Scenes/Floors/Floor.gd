extends Node2D

const Spawn_effect_scene: PackedScene = preload("res://Characters/Enemies/SpawnEffect.tscn")

const Enemy_scenes_dict: Dictionary = {"Bat": preload("res://Characters/Enemies/Bat/Bat.tscn"), 
"greenBat": preload("res://Characters/Enemies/Bat/greenBat/greenBat.tscn"), 
"redBat": preload("res://Characters/Enemies/Bat/redBat/redBat.tscn"),
 "Gremlin": preload("res://Characters/Enemies/Gremlin/Gremlin.tscn"),
"blueGremlin": preload("res://Characters/Enemies/Gremlin/blueGremlin/blueGremlin.tscn"),
"redGremlin": preload("res://Characters/Enemies/Gremlin/redGremlin/redGremlin.tscn")
}

var num_enemies: int

onready var tilemap: TileMap = get_node("TileMap2")
onready var entrance: Node2D = get_node("Entrance")
onready var door_container: Node2D = get_node("Doors")
onready var enemy_positions_container: Node2D = get_node("EnemyPosistions")
onready var player_detector: Area2D = get_node("PlayerDetector")

var rng = RandomNumberGenerator.new()

export(int) var num_levels: int = 0

func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()
	
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()

func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()

func _close_entrance() -> void:
	for entry_position in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), 15)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position) + Vector2.DOWN, 0)

func _spawn_enemies() -> void:
	
	for enemy_position in enemy_positions_container.get_children():
		rng.randomize()
		var my_random_number = rng.randi_range(0, 5)
		var enemy: KinematicBody2D
		if my_random_number == 0:
			enemy = Enemy_scenes_dict.Bat.instance()
		elif my_random_number == 1:
			enemy = Enemy_scenes_dict.greenBat.instance()
		elif my_random_number == 2:
			enemy = Enemy_scenes_dict.redBat.instance()
		elif my_random_number == 3:
			enemy = Enemy_scenes_dict.blueGremlin.instance()
		elif my_random_number == 4:
			enemy = Enemy_scenes_dict.redGremlin.instance()
		else:
			enemy = Enemy_scenes_dict.Gremlin.instance()
		
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.global_position = enemy_position.position
		call_deferred("add_child", enemy)
		
		var Spawn_effect: AnimatedSprite = Spawn_effect_scene.instance()
		enemy.global_position = enemy_position.position
		call_deferred("add_child", Spawn_effect)


func _on_PlayerDetector_body_entered(_body: KinematicBody2D) -> void:
	player_detector.queue_free()
	
	if num_enemies > 0:
		_close_entrance()
		_spawn_enemies()
	else:
		_open_doors()
