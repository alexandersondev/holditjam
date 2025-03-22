/// @description Insert description here
// You can write your code in this editor
//swap mech to room

//see if mech is set
//create a default mech
if mech = noone {
	mech = instance_create_layer(x, y, "Instances", o_mech)
} else {
	with mech {
		room_goto(other.room)	
	}
}
mech.x = o_player.x
mech.y = o_player.y