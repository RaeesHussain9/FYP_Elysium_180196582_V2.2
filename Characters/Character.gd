extends KinematicBody2D
class_name Character


const FRICTION: float = 0.15

export(int) var acceleration: int = 40
export(int) var max_speed: int = 100

export(int) var hp: int = 2 setget set_hp
signal hp_changed(set_hp)

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready():
	animated_sprite.visible = true

func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * acceleration
	velocity = velocity.clamped(max_speed)

func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt or state_machine.state != state_machine.states.death:
		self.hp -= dam
		if name == "Player":
			SavedData.hp = hp
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.death)
			velocity += dir * force * 2


func set_hp(new_hp: int) -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)
