extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

const speed = 100
var last_anim_dir = "front"

var intro_dialog_triggered = false

func _physics_process(delta: float) -> void:
	player_movement(delta)
	pass
	
func player_movement(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		#if not intro_dialog_triggered:
			#intro_dialog_triggered = true
			#DialogueManager.show_example_dialogue_balloon(preload("res://dialog/main.dialogue"), "start")
		play_anim("right", true)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim("left", true)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim("down", true)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		play_anim("up", true)
		velocity.y = -speed
		velocity.x = 0
	else:
		velocity = Vector2(0, 0)
		play_anim("none", false)


	move_and_slide()

func play_anim(dir, is_moving):

	if is_moving:
		if dir == "right":
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("side_walk")
			last_anim_dir = "side"
		elif dir == "left":
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("side_walk")
			last_anim_dir = "side"
		elif dir == "down":
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("front_walk")
			last_anim_dir = "front"
		elif dir == "up":
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("back_walk")
			last_anim_dir = "back"
	else:
		var anim_to_play =  last_anim_dir + "_idle"
		animated_sprite_2d.play(anim_to_play)
