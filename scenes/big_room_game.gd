extends Node2D



func _on_initial_mission_timer_timeout() -> void:
	DialogueManager.show_example_dialogue_balloon(preload("res://dialog/main.dialogue"), "task_chair")
