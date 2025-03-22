/// @description Insert description here
// You can write your code in this editor
x += dcos(bullet_direction)*bullet_velocity
y += dsin(bullet_direction)*bullet_velocity

//if hits a mech

if tilemap_get_at_pixel(layer_get_id("collision"), bbox_right, y) {
	
}

if place_meeting(x, y, o_mech) {
	
}