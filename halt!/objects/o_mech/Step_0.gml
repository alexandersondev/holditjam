/// @description Insert description here
// You can write your code in this editor
cntrlstate.step()

//bring weapon along with it
if weapon != noone {
weapon.x = x
weapon.y = y-7
weapon.owner = self
}
if player_owned {
	weapon.player_owned = true
}

//show_debug_message("xVelocity: " + string(velocity_x))
//show_debug_message("yVelocity: " +string(velocity_y))
//show_debug_message("move left: " +string(move_left))
//show_debug_message("move right: " + string(move_right))