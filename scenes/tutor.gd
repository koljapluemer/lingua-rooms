extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


var dia = load("res://dialog/main.dialogue")
func _ready():
	animated_sprite_2d.play("idle")
	
	var dialogue_line = await DialogueManager.show_dialogue_balloon(dia, "demo")
