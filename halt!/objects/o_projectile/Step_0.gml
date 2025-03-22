/// @description Insert description here
// You can write your code in this editor
x += lengthdir_x(bullet_velocity, bullet_direction)
y += lengthdir_y(bullet_velocity, bullet_direction)

//if hits a mech

if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), x, y) {
	instance_destroy()
}

if place_meeting(x, y, o_mech){
	if _impact = false {
		mech = instance_place(x,y,o_mech)
		mech.take_damage(hit_damage)
		if after_life_hit == 0 {
			instance_destroy()
		}	else {
			alarm[0] = after_life_hit	
			bullet_velocity =after_hit_velocity
		}
	} else {
		mech.take_damage(tick_damage)	
	}
}
