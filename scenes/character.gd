extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

@export var speed = 100
@export var accel = 10

var intro_dialog_triggered = false

var facing_direction: Vector2 = Vector2(0, 1)


enum AnimationType {
	IDLE_DOWN,
	IDLE_UP,
	IDLE_LEFT,
	IDLE_RIGHT,
	MOVE_DOWN,
	MOVE_UP,
	MOVE_LEFT,
	MOVE_RIGHT
}
const animation_names = {
	AnimationType.IDLE_DOWN: "front_idle",
	AnimationType.IDLE_UP: "back_idle",
	AnimationType.IDLE_LEFT: "side_idle",
	AnimationType.IDLE_RIGHT: "side_idle",
	AnimationType.MOVE_DOWN: "front_walk",
	AnimationType.MOVE_UP: "back_walk",
	AnimationType.MOVE_LEFT: "side_walk",
	AnimationType.MOVE_RIGHT: "side_walk"
}

func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector2(0, 0)
	if direction != Vector2(0, 0):
		velocity = direction.normalized() * speed
		facing_direction = direction
	move_and_slide()
	manage_animations()
	


func manage_animations() -> void:
	if velocity.x > 0:
		animated_sprite_2d.play(animation_names[AnimationType.MOVE_RIGHT])
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.play(animation_names[AnimationType.MOVE_LEFT])
		animated_sprite_2d.flip_h = true
	elif velocity.y > 0:
		animated_sprite_2d.play(animation_names[AnimationType.MOVE_DOWN])
		animated_sprite_2d.flip_v = false
	elif velocity.y < 0:
		animated_sprite_2d.play(animation_names[AnimationType.MOVE_UP])
		animated_sprite_2d.flip_v = false
	else:
		if facing_direction.x > 0:
			animated_sprite_2d.play(animation_names[AnimationType.IDLE_RIGHT])
			animated_sprite_2d.flip_h = false
		elif facing_direction.x < 0:
			animated_sprite_2d.play(animation_names[AnimationType.IDLE_LEFT])
			animated_sprite_2d.flip_h = true
		elif facing_direction.y > 0:
			animated_sprite_2d.play(animation_names[AnimationType.IDLE_DOWN])
			animated_sprite_2d.flip_v = false
		elif facing_direction.y < 0:
			animated_sprite_2d.play(animation_names[AnimationType.IDLE_UP])
			animated_sprite_2d.flip_v = false
