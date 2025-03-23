/// @description Insert description here
// You can write your code in this editor
global.playermech = noone
global.playercam = noone

global.savedequipment = false

function change_room(rm_index) {
	if instance_exists(global.playermech) {
		with global.playermech {
			room_goto(rm_index)
		}
	}
	room_goto(rm_index)	
}

instance_create_layer(x,y,"Instances", o_gui)