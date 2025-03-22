/// @description game setup
show_debug_message("Setting up the game!")
#region macros
#macro  COLLISION_TILEMAP = layer_tilemap_get_id(layer_get_id("collision"))

enum MOVE {
	left, 	
	right,
	down,
	up,
	shoot,
	reload,
	swap
}

#endregion

randomise()