extends Area2D
class_name Hitbox

export(int) var damage: int = 1
var knockback_direction: Vector2 = Vector2.ZERO
export(int) var knockback_force: int = 300

var inside_body: bool = false

onready var collision_shape: CollisionShape2D = get_child(0)
onready var timer: Timer = Timer.new()

func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")

func _ready() -> void:
	assert(collision_shape != null)
	timer.wait_time = 1
	add_child(timer)

func _on_body_entered(body: PhysicsBody2D) -> void:
	inside_body = true
	timer.start()
	while inside_body:
		_collide(body)
		yield(timer, "timeout")

func _on_body_exited(_body: KinematicBody2D) -> void:
	inside_body = false
	timer.stop()

func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)


