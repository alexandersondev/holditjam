/// @description Insert description here
// You can write your code in this editor

//TILEMAP TO CHECK FOR COLLISION


velocity_x = 0
velocity_y = 0
deacceleration = 4.5;
velocity_limit = 20;

//CONTROL
aiming_direction = 0


#region MOVES
shoot = false
move_left = false 
move_right = false
move_down = false 
move_up = false
reload = false 
swap = false 

function start_move(move) {
	switch(move) {
		case MOVE.left:
			move_left = true
		break;
		case MOVE.right:
			move_right = true
		break;
		case MOVE.up:
			move_up = true
		break;
		case MOVE.down:
			move_down = true
		break;
		case MOVE.reload:
			move_reload = true
		break;
		case MOVE.shoot:
			shoot = true
		break;
		case MOVE.swap:
			swap = true
		break;
	}
}

function end_move(move) {
	switch(move) {
		case MOVE.left:
			move_left = false
		break;
		case MOVE.right:
			move_right = false
		break;
		case MOVE.up:
			move_up = false
		break;
		case MOVE.down:
			move_down = false
		break;
		case MOVE.reload:
			move_reload = false
		break;
		case MOVE.shoot:
			shoot = false
		break;
		case MOVE.swap:
			swap = false
		break;
	}	
}
#endregion

//default equipment
#region EQUIPMENT
chassis = {
		durability: 100,
		weight: 10
		};
transport = {
		durability: 100,
		weight: 10,
		force: 15
		};
//maybe own object for state machine instead of just a struct?
weapon = instance_create_layer(x, y, "instances", o_weapon)
weapon.owner = self
weapon.player_owned = true
if player_owned {
	weapon.player_owned = true	
}
#endregion

#region helper functions
function get_weight(){
	//check if anything is destroyed, than just add 10 as a default value
	var weight_sum = 1;
	if chassis.durability > 0 {
		weight_sum += 5	
	}
	if transport.durability > 0 {
		weight_sum += 5
	}
	if weapon.durability > 0 {
		weight_sum += 5
	}
	return weight_sum
}

function apply_force(force, force_direction){
	
	var f_x = force*dcos(force_direction)
	var f_y = force*dsin(force_direction)
	show_debug_message("f_x:" + string(f_x))
	show_debug_message("f_y:" + string(f_y))
	show_debug_message("f_dir:" + string(force_direction))
	
	velocity_x += f_x*force/get_weight()
	velocity_y += f_y*force/get_weight()
	
}

function calculate_speed() {
	
	//normalize the vector if it's above the velocity limit
	//OR::: FOR NOW:: WE ARE SIMPLY USING AN EXPONENTIAL FRICTION DEACCELERATOR
	velocity_x = clamp(velocity_x, -velocity_limit, velocity_limit)
	velocity_y = clamp(velocity_y, -velocity_limit, velocity_limit)
	
	var _vector_length;
		
	//apply equal deacceleration, check in case they're both 0
	if abs(velocity_x) > 0 and abs(velocity_y) > 0 {
		_vector_length = sqrt(power(velocity_x,2)+power(abs(velocity_y),2))
		var y_ratio = abs(dsin(point_direction(0,0, velocity_x, velocity_y)))
		var x_ratio = abs(dcos(point_direction(0,0, velocity_x, velocity_y)))
		
		//make sure it doesn't "bounce back")
		if sign(velocity_y) == -1 {
			velocity_y =clamp(velocity_y-sign(velocity_y)*(y_ratio*deacceleration*(power(0.1*_vector_length,2)))
			,velocity_y
			,0	
			)
		} else {
			velocity_y =clamp(velocity_y-sign(velocity_y)*(y_ratio*deacceleration*(power(0.1*_vector_length,2)))
			,0
			,velocity_y	
			)			
		}
		//we can calculate the x ratio by inverting it
		if sign(velocity_x) == -1 {
		velocity_x = clamp(velocity_x-sign(velocity_x)*((x_ratio)*deacceleration*(power(0.1*_vector_length,2)))
		,velocity_x
		,0
		)
		} else { 
			velocity_x =clamp(velocity_x-sign(velocity_x)*((x_ratio)*deacceleration*(power(0.1*_vector_length,2)))
			,0
			,velocity_x
			)			
		}
	} else {
		if abs(velocity_y) > 0 {
			_vector_length = velocity_y
			if sign(velocity_y) == -1 {
				velocity_y =clamp(velocity_y-sign(velocity_y)*(deacceleration*(power(0.1*_vector_length,2)))
				,velocity_y
				,0	
				)
			} else {
				velocity_y =clamp(velocity_y-sign(velocity_y)*(deacceleration*(power(0.1*_vector_length,2)))
				,0
				,velocity_y	
				)			
			}
		} else {
			_vector_length = velocity_x
			if sign(velocity_x) == -1 {
			velocity_x = clamp(velocity_x-sign(velocity_x)*(deacceleration*(power(0.1*_vector_length,2)))
			,velocity_x
			,0
			)
			} else { 
				velocity_x =clamp(velocity_x-sign(velocity_x)*(deacceleration*(power(0.1*_vector_length,2)))
				,0
				,velocity_x
				)			
			}
		}
	}
	//cap if it goes under 1
	if abs(velocity_x) < 1 {velocity_x=0}
	if abs(velocity_y) < 1 {velocity_y=0}
} 

function apply_velocity() {
	var _xmovement = velocity_x 
	var _ymovement = velocity_y
	//show_debug_message("xVelocity: " + string(_xmovement))
	//show_debug_message("yVelocity: " +string(_ymovement))
	
	while floor(abs(_xmovement))>0 {
		if sign(_xmovement) == 1 {
			if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), bbox_right+1, y-5) == 0 {
				x+=1
				_xmovement -= sign(_xmovement)
				//show_debug_message("No tile detected, moving x position")
			} else {
				break	
				}
			} else if sign(_xmovement)==-1 {
				if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), bbox_left-1, y-5) == 0 {
					x-=1
					_xmovement -= sign(_xmovement)
					//show_debug_message("No tile detected, moving x position")
				} else {
				break	
				}		
			}
	}
	while floor(abs(_ymovement))>0{
			if sign(_ymovement)==1 {
				if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), x, bbox_bottom+1) == 0 {
					y+=1
					_ymovement -= sign(_ymovement)
				//show_debug_message("No tile detected, moving x position")
				} else {
					 break	
					}
				}
			if sign(_ymovement)==-1 {
				if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), x, bbox_top-1) == 0 {
					y-=1
					_ymovement -= sign(_ymovement)
				//show_debug_message("No tile detected, moving x position")
				} else {
					 break
					}		
				}
			show_debug_message("ymovement"+string(_ymovement))
			}
	}




function die(){
	
}

function take_damage(damage) {
	//chooses any real value between 0 and 1 
	choice_list = ds_list_create()
	
	//set our ranges
	var _weapon_range = clamp(weapon.weight / get_weight()*100, 0, 100)
	var _transport_range = clamp(transport.weight / get_weight()*100, 0, 100)
	var _chassis_range = clamp(chassis.weight / get_weight()*100, 0, 100)
	
	if weapon.durability > 0 {
		for (i=0; i<_weapon_range; i++) {
				ds_list_add(choice_list, "w")
		}
	}
	if transport.durability > 0 {
		for (i=0; i<_transport_range; i++) {
				ds_list_add(choice_list, "t")
		}
	}
	if chassis.durability > 0 {
				for (i=0; i<_chassis_range; i++) {
				ds_list_add(choice_list, "c")
		}
		
	}
	
	choice = choice_list[irandom(ds_list_size(choice_list)-1)]
	if choice == "w" {
		weapon.durability -= damage;
	}
	if choice == "t" {
		transport.durability -= damage;
	}
	if choice == "c" {
		if damage > chassis_durability  {
			die()
		}
	}
	//choose based on result
}


#endregion

//manage player movement
mvmstate = new SnowState("idle");
//manage player combat
cmbtstate = new SnowState("idle");
//manage player control
cntrlstate = new SnowState("combat");

#region MOVEMENT STATES
mvmstate.add("idle", {
	enter: function() {
		
	},
	step: function() {
		//move 
		calculate_speed()
		apply_velocity();
		if move_left or move_right or move_up or move_down {
			mvmstate.change("transport_active")
			return 0
		}	
	}
})
mvmstate.add("transport_active", {
	enter: function() {
		
	},
	step: function() {
		
		calculate_speed()
		apply_velocity()
		var _x = 0
		var _y = 0
		if move_left {_x -= 1}
		if move_right {_x += 1}
		if move_up {_y+=1}
		if move_down{_y-=1}
		if _x=0 and _y=0 {
			mvmstate.change("idle")	
			return 0
		}
		apply_force(transport.force, point_direction(0,0, _x, _y))
		if move_left == false and move_right == false and move_up == false and move_down == false {
			mvmstate.change("idle");	
			return 0
		}
	}
})
#endregion 

cmbtstate.add("idle", {
	step: function () {
		if shoot {
			cmbtstate.change("fire")	
		}
	}
})

cmbtstate.add("fire", {
	step: function () {
		weapon.fire()
		if !shoot {
			cmbtstate.change("idle")	
		}
	}
})



cntrlstate.add("combat", {
	enter: function() {
		
	},
	step: function() {
		mvmstate.step()
		cmbtstate.step()
	}
})