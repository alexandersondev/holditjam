/// @description Insert description here
// You can write your code in this editor

//CHECK For door
with global.playermech { 
	if place_meeting(x, y, o_door) {
		if input_check("interact") {
			other.change_room(instance_place(x,y, o_door).goto_next())
		}
	}
}


global.playermech.aiming_direction = point_direction(global.playermech.x,
global.playermech.y, mouse_x, mouse_y)

//update mech's moves
if global.playermech != noone {
	//follow mech
	x = global.playermech.x
	y = global.playermech.y
	
	if input_check("left") {
		global.playermech.start_move(MOVE.left)	
	} else {
		global.playermech.end_move(MOVE.left)	
	}
	if input_check("right") {
		global.playermech.start_move(MOVE.right)	
	} else {
		global.playermech.end_move(MOVE.right)	
	}
	if input_check("up") {
		global.playermech.start_move(MOVE.up)	
	} else {
		global.playermech.end_move(MOVE.up)	
	}
	if input_check("down") {
		global.playermech.start_move(MOVE.down)	
	} else {
		global.playermech.end_move(MOVE.down)	
	}
	if input_check("shoot") {
		global.playermech.start_move(MOVE.shoot)	
	} else {
		global.playermech.end_move(MOVE.shoot)	
	}
	if input_check("swap") {
		global.playermech.start_move(MOVE.swap)	
	} else {
		global.playermech.end_move(MOVE.swap)	
	}
	if input_check("reload") {
		global.playermech.start_move(MOVE.reload)	
	} else {
		global.playermech.end_move(MOVE.reload)	
	}
}