extends Hitbox

var throwing_Direction: Vector2 = Vector2.ZERO
var knife_velocity: int = 0

var enemy_exited: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func launch(initial_position: Vector2, dir: Vector2, velocity: int) -> void:
	position = initial_position
	throwing_Direction = dir
	knockback_direction = dir
	knife_velocity = velocity
	
	rotation += dir.angle() + PI/4
	

func _physics_process(delta: float) -> void:
	position += throwing_Direction * knife_velocity * delta


func _on_ThrowingKnife_body_exited(_body: KinematicBody2D) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0,true)
		set_collision_mask_bit(1,true)
		set_collision_mask_bit(2,false)

func _collide(body: KinematicBody2D) -> void:
	if enemy_exited == true:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
			queue_free()
