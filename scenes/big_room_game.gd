extends Node2D

var target_cells = {}

func _on_initial_mission_timer_timeout() -> void:
	DialogueManager.show_example_dialogue_balloon(preload("res://dialog/main.dialogue"), "task_chair")

func handle_tilemap_data() -> void:
	var tilemap = $TileMap
	var nr_of_layers = tilemap.get_layers_count()
	for i in range(nr_of_layers):
		for cell in tilemap.get_used_cells(i):
			var tile_data: TileData = tilemap.get_cell_tile_data(i, cell)
			if tile_data:
				var custom_data = tile_data.get_custom_data("name")
				if custom_data:
					# if a dict for this name already exist, append cell
					# if not, make dict with this cell coords
					if custom_data in target_cells:
						target_cells[custom_data].append(cell)
					else:
						target_cells[custom_data] = [cell]
			

func _ready():
	handle_tilemap_data()
	send_tutor_on_example_mission()

func send_tutor_on_example_mission() -> void:
	var target_cell = target_cells["box"][randi() % target_cells["box"].size()]
	# convert to global coords
	var target_position = $TileMap.map_to_local(target_cell)
	$Tutor.set_target(target_position)
