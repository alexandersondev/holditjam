/// @description Insert description here
// You can write your code in this editor


//update mech's moves
if mech != noone {
	
	if input_check("left") {
		mech.start_move(MOVE.left)	
	} else {
		mech.end_move(MOVE.left)	
	}
	if input_check("right") {
		mech.start_move(MOVE.right)	
	} else {
		mech.end_move(MOVE.right)	
	}
	if input_check("up") {
		mech.start_move(MOVE.up)	
	} else {
		mech.end_move(MOVE.up)	
	}
	if input_check("down") {
		mech.start_move(MOVE.down)	
	} else {
		mech.end_move(MOVE.down)	
	}
	if input_check("shoot") {
		mech.start_move(MOVE.shoot)	
	} else {
		mech.end_move(MOVE.shoot)	
	}
	if input_check("swap") {
		mech.start_move(MOVE.swap)	
	} else {
		mech.end_move(MOVE.swap)	
	}
	if input_check("reload") {
		mech.start_move(MOVE.reload)	
	} else {
		mech.end_move(MOVE.reload)	
	}
}