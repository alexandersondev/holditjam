/// @description Insert description here
// You can write your code in this editor
behaviorState = new SnowState("idle");
controlledMech = instance_create_layer(x, y, "Instances", o_mech);
engage_distance = 600;
stay_distance = 64;

with controlledMech {
	//randomize states
	chassis.durability = irandom_range(15,50) 
	chassis.weight = irandom_range(15,50)

	weapon.durability = irandom_range(15,50)
	weapon.weight = irandom_range(15,50)
	weapon.fire_slowdown = irandom_range(4,10)
	weapon.damage = irandom_range(3,23)
	
	transport.weight = irandom_range(5, 20)
	transport.durability = irandom_range(20, 50)
	
	transport.force = irandom_range(5,30)
	
	sprite_index = choose(Sprite12, Sprite13)
}

chasePath = path_add();

function walk_path() {
	//check what direciton is closest
	var _dir = point_direction(controlledMech.x, controlledMech.y, o_player.x, o_player.y)
	controlledMech.apply_force(controlledMech.transport.force,
	_dir)
	
	
}


behaviorState.add("idle", {step: function() {
			controlledMech.mvmstate.change("idle")
			//WAIT FOR PLAYER TO GET IN RANGE
			//DRAW LINE AND SEE IF PLAYER IS VISIBLE/NOT BEYOND A CERTAIN GATE
			player_dist = distance_to_object(global.playermech)
			if player_dist <= engage_distance {
				behaviorState.change("engage")	
			}
			controlledMech.move_left = false
			controlledMech.move_right = false 
			controlledMech.move_up = false 
			controlledMech.move_down = false
			
	}
})

behaviorState.add("engage", {step: function() {
		controlledMech.mvmstate.change("transport_active")
		//walk_path()
		//idk 
		with controlledMech {
			aiming_direction = 	point_direction(x, y, global.playermech.x, global.playermech.y)
			weapon.fire()
		}

		if distance_to_object(global.playermech) > stay_distance {
		//find furthest direction
		var _updist = abs(controlledMech.y-global.playermech.y)
		var _downdist = abs(controlledMech.x-global.playermech.x)
		
		if _updist > _downdist {
			controlledMech.move_right = false 
			controlledMech.move_left = false
			if controlledMech.y > global.playermech.y {
				controlledMech.move_up = true
				controlledMech.move_down = false
			} else {
				controlledMech.move_down = true
				controlledMech.move_up = false
			}	
		} else {
			controlledMech.move_up = false 
			controlledMech.move_down = false
			if controlledMech.x < global.playermech.x {
				controlledMech.move_right = true	
				controlledMech.move_left = false
			} else {
				controlledMech.move_left = true
				controlledMech.move_right = false
			}
		}
		} else {
			controlledMech.move_left = false
			controlledMech.move_right = false
			controlledMech.move_up = false
			controlledMech.move_down = false
		}
		
		//APPROACH PLAYER FOR OPTIMAL DISTANCE AND FIRE
		//TRY TO HAVE SOMEWHAT INTERESTING MOVEMENT - MOVE IN A CIRCLE AROUND?
		player_dist = distance_to_object(global.playermech)
		if player_dist > engage_distance {
				behaviorState.change("idle")
		}
		
		
	}
})

behaviorState.add("dead", {step: function() {
		
	}
})


