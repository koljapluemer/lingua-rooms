extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

const speed = 20

@export var node_destination: Node2D
@onready var nav_agent = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = node_destination.global_position


func _ready():
	animated_sprite_2d.play("idle")


func _on_timer_timeout() -> void:
	make_path()
