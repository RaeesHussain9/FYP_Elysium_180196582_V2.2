extends CanvasLayer


func _ready():
	pass

func _init() -> void:
	var screen_size: Vector2 = OS.get_screen_size()
	var window_size: Vector2 = OS.get_window_size()
	
	OS.set_window_position(screen_size * 0.5 - window_size * 0.5)



func _on_Start_pressed():
	SceneChanger.start_transition_to("res://Scenes/DungeonFloors/Game.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
