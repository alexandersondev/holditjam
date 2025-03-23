/// @description Insert description here
// You can write your code in this editor
setup = false
follow_object = noone

view_width = 640
view_height = 480

function configCamera(_follow_object) {
	setup = true
	follow_object = _follow_object
	view_enabled = true 
	view_enabled[0] =true;
	view_visible[0] = true;
	
}