extends TileMapLayer

var game_manager : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_node("%GameManager")

func HitBrick(position : Vector2i):
	erase_cell(position)
	
	if not get_used_cells():
		game_manager.Victory()
	#set_cell(position, -1)
	#set_cells_terrain_connect(get_used_cells(),  0, false)
	
