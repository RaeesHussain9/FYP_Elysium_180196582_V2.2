extends Character

enum {UP, DOWN}

var equipped_weapon: Node2D
onready var weapons: Node2D = get_node("Weapons")

#onready var slash_sprite: Sprite = sword.get_node("SlashSprite")

func _ready():
	equipped_weapon = weapons.get_child(0)
	weapons.get_child(1).hide()
	weapons.get_child(2).hide()
	#slash_sprite.visible = false
	#sword_collision.disabled = true
	_restore_previous_state()

func _restore_previous_state() -> void:
	self.hp = SavedData.hp
	

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	
	equipped_weapon.moveMouse(mouse_direction)
	
	
func get_input() -> void:
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP
	
	if not equipped_weapon.is_busy():
		if Input.is_action_just_released("ui_next_weapon"):
			switch_weapon(UP)
		elif Input.is_action_just_released("ui_previous_weapon"):
			switch_weapon(DOWN)
	
	equipped_weapon.get_input()

func switch_weapon(dir: int) -> void:
	var index: int = equipped_weapon.get_index()
	if dir == UP:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
	else:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	
	equipped_weapon.hide()
	equipped_weapon = weapons.get_child(index)
	equipped_weapon.show()

func camera_switch() -> void:
	var main_camera: Camera2D = get_parent().get_node("Camera2D")
	main_camera.position = position
	main_camera.current = true
	get_node("Camera2D").current = false
	
