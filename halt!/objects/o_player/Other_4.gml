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

