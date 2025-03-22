/// @description Insert description here
// You can write your code in this editor
var _pointtowhat

_pointtowhat = owner.aiming_direction

if sprite_height < weapon_length {
	image_xscale = weapon_length/abs(sprite_height)
	image_yscale = weapon_length/abs(sprite_height)
}

image_angle = _pointtowhat

draw_self()

draw_circle(x+lengthdir_x(sprite_height,
		image_angle), y+lengthdir_y(sprite_height, image_angle), 6, true)