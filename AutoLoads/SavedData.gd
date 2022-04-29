extends Node

var num_levels: int = 0

var hp: int = 4
var weapons: Array = []
var equipped_weapon_index: int = 0

func _ready():
	print("saved data num levels = " + str(num_levels))
	


func reset_data() -> void:
	num_levels = 0
