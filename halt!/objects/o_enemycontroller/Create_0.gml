/// @description Insert description here
// You can write your code in this editor
behaviorState = new SnowState("idle");
controlledMech = instance_create_layer(x, y, "Instances", o_mech);
engage_distance = 600;

with controlledMech {
	//randomize states
	controlledMech.chassis.durability = irandom_range(15,50) 
	controlledMech.chassis.weight = irandom_range(15,50)

	controlledMech.weapon.durability = irandom_range(15,50) 
	controlledMech.weapon.weight = irandom_range(15,50)
	controlledMech.weapon.fire_slowdown = irandom_range(1,10)
	controlledMech.weapon.damage = irandom_range(3,23)
	
	controlledMech.transport.force = irandom_range(5, 20)
	controlledMech.transport.weight = irandom_range(5, 20)
	controlledMech.transport.durability = irandom_range(20, 50)
	
}



behaviorState.add("idle", {step: function() {
			//WAIT FOR PLAYER TO GET IN RANGE
			//DRAW LINE AND SEE IF PLAYER IS VISIBLE/NOT BEYOND A CERTAIN GATE
			player_dist = distance_to_object(global.playermech)
			if player_dist <= engage_distance {
				behaviorState.change("engage")	
			}
			
	}
})

behaviorState.add("engage", {step: function() {
		//APPROACH PLAYER FOR OPTIMAL DISTANCE AND FIRE
		//TRY TO HAVE SOMEWHAT INTERESTING MOVEMENT - MOVE IN A CIRCLE AROUND?
		player_dist = distance_to_object(global.playermech)
		if player_dist > engage_distance {
				behaviorState.change("idle")	
		}
	}
})


