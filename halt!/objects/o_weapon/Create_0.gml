/// @description Insert description here
// You can write your code in this editor
weight = 10
durability = 10
length = 7
fire_slowdown= 10
ammo_max = 10
ammo = 0;
//alarm[0] as reload time


function fire() {
	show_debug_message("fired!")
	if alarm[0] < 1 {
		var _bullet = instance_create_layer(x+lengthdir_x(sprite_height,
		image_angle), y+lengthdir_y(sprite_height, image_angle), "Instances", o_projectile)
		_bullet.image_angle = image_angle
		_bullet.bullet_direction = point_direction(x, y, x+lengthdir_x(sprite_height,
		image_angle), y+lengthdir_y(sprite_height, image_angle))
		alarm[0] = fire_slowdown
		show_debug_message("fired succesfully!")
	} 
}

