/// @description Insert description here
// You can write your code in this editor

//TILEMAP TO CHECK FOR COLLISION


velocity_x = 0
velocity_y = 0
deacceleration = 1;
velocity_limit = 10;

//default equipment
#region EQUIPMENT
chassis = {
		durability: 100,
		weight: 10
		};
transport = {
		durability: 100,
		weight: 10,
		force: 25
		};
//maybe own object for state machine instead of just a struct?
weapon = {
		state: "doing nuttin",
		ammo: 10,
		weight: 10,
		durability:100,
		fire: function () { //replace later
			show_debug_message("Hey, create the default weapon!")	
			ammo -= 1;
		},
		reload: function() {
			ammo += 10; //add reload functionality later	
		},
		ReturnAmmoCount: function () {
			return ammo;
		},
		ReturnWeaponStatus: function () {
			return state
		}
}
#endregion

#region helper functions
function get_weight(){
	//check if anything is destroyed, than just add 10 as a default value
	var weight_sum = 0;
	if chassis.durability = 0 {
		weight_sum += 5	
	}
	if transport.durability = 0 {
		weight_sum += 5
	}
	if weapon.durability = 0 {
		weight_sum += 5
	}
	return weight_sum
}

function apply_force(force, force_direction){
	
	var f_x = force*cos(force_direction)
	var f_y = force*sin(force_direction)
	
	velocity_x += f_x
	velocity_y += f_y
	
}

function calculate_speed() {
	
	//normalize the vector if it's above the velocity limit
	var _vector_length = sqrt(power(velocity_x,2)+power(abs(velocity_y),2))
	if _vector_length > 4 {
		if _vector_length > velocity_limit {
			velocity_x = (velocity_x/_vector_length)*(velocity_limit)
		}
		if _vector_length > velocity_limit {
			velocity_x = (velocity_y/_vector_length)*(velocity_limit)
		}
	}
	
	//apply equal deacceleration
	if abs(velocity_x) > 0 and abs(velocity_y) > 0 {
		var y_ratio = velocity_y/(abs(velocity_x)+abs(velocity_y))
		velocity_y -= sign(velocity_y)*y_ratio*deacceleration*(power(0.1*_vector_length,2))
		//we can calculate the x ratio by inverting it
		velocity_x -= sign(velocity_x)*(1/y_ratio)*deacceleration*(power(0.1*_vector_length,2))
	} else {
		
	}
}

function apply_velocity() {
	var _xmovement = velocity_x 
	var _ymovement = velocity_y
	
	while floor(abs(_xmovement))>0 {
		
		if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), x+sign(_xmovement), y) {
			x += sign(_xmovement)
			_xmovement -= sign(_xmovement)
		} else {
			_xmovement=0	
		}
	}
	while floor(abs(_ymovement))>0{
		if tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("collision")), x, +sign(_ymovement)) {
			x += sign(_ymovement)
			_ymovement -= sign(_ymovement)
		} else {
			_ymovement=0	
		}
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
		apply_deacceleration();
		apply_velocity();
	}
})
#endregion 



cntrlstate.add("combat", {
	enter: function() {
		
	},
	step: function() {
		mvmstate.step()
		cmbtstate.step()
	}
})