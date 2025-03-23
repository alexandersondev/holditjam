/// @description Insert description here
// You can write your code in this editor
//swap mech to room

//see if mech is set
//create a default mech
_currentroom = room
if global.playermech = noone {
	global.playermech = instance_create_layer(x, y, "Instances", o_mech)
	
} else {
	with global.playermech {
		//room_goto(other._currentroom)
	}
	//room_instance_add(global.playermech, x, y, o_mech);
}
if global.savedequipment = true {
	global.playermech.weapon = global.playerweapon	
	global.playermech.transport = global.playerweapon	
	global.playermech.chassis = global.playerweapon	
}

if global.playercam = noone {
	global.playercam = instance_create_layer(x, y, "Instances", o_camera)
	global.playercam.follow_object = global.playermech
	global.playercam.configCamera(global.playermech)
} else {
	with global.playercam {
		//room_goto(other._currentroom)
	}
	global.playercam.configCamera(global.playermech)

}
//go to to start point
if instance_exists(o_spawnpoint) {
x = o_spawnpoint.x
y = o_spawnpoint.y

}

global.playermech.x = x
global.playermech.y = y
global.playermech.player_owned = true


//create grid for enemies to follow

var cellsize = 16;
var roomWidth = room_width div cellsize;
var roomHeight = room_height div cellsize;
global.collisionGrid = mp_grid_create(0,0, roomWidth, roomHeight, cellsize, cellsize);

var collisionLayerID = layer_tilemap_get_id("collision");

for (var i=0; i < roomWidth; i++){
	for(var j = 0; j < roomHeight; j++){
	if (tilemap_get(collisionLayerID, i, j)){// I think this is the error
		mp_grid_add_cell(global.collisionGrid, i, j);
		}
	}
}