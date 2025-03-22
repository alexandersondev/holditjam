/// @description Insert description here
// You can write your code in this editor
//swap mech to room

//see if mech is set
//create a default mech
if global.playermech = noone {
	global.playermech = instance_create_layer(x, y, "Instances", o_mech)

} else {
	with global.playermech {
		room_goto(other.room)	
	}
}

global.playermech.x = o_player.x
global.playermech.y = o_player.y
global.playermech.player_owned = true
