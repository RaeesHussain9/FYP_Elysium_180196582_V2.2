extends Area2D

onready var collison_shape: CollisionShape2D = get_node("CollisionShape2D")

func _ready():
	pass # Replace with function body.



func _on_Stairs_body_entered(_body: KinematicBody2D):
	collison_shape.set_deferred("disabled", true)
	SceneChanger.start_transition_to("res://Scenes/DungeonFloors/Level2.tscn")
