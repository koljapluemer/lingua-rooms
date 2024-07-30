extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

const speed = 50

@export var node_destination: Node2D
@onready var nav_agent = $NavigationAgent2D

var facing_direction: Vector2 = Vector2(0, 1)

enum AnimationType {
	IDLE,
	MOVE_DOWN,
	MOVE_UP,
	MOVE_LEFT,
	MOVE_RIGHT
}
const animation_names = {
	AnimationType.IDLE: "idle",
	AnimationType.MOVE_DOWN: "walk_front",
	AnimationType.MOVE_UP: "walk_back",
	AnimationType.MOVE_LEFT: "walk_side",
	AnimationType.MOVE_RIGHT: "walk_side"
}


func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	# if position to destination is less than 50 pixels, stop moving
	if to_local(nav_agent.target_position).length() < 20:
		velocity = Vector2(0, 0)
		animated_sprite_2d.play(animation_names[AnimationType.IDLE])
		return
	facing_direction = dir
	velocity = dir * speed
	move_and_slide()
	manage_animations()


func make_path() -> void:
	nav_agent.target_position = node_destination.global_position


func _ready():
	animated_sprite_2d.play("idle")


func _on_timer_timeout() -> void:
	make_path()

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
		animated_sprite_2d.play(animation_names[AnimationType.IDLE])
		animated_sprite_2d.flip_h = false
