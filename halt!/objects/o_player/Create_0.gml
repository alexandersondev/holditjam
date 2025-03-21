/// @description Insert description here
// You can write your code in this editor

//default equipment
#region EQUIPMENT
chassis = {
		durability: 100,
		weight: 10
		};
transport = {
		durability: 100,
		weight: 10,
		force: 10
		};
//maybe own object for state machine instead of just a struct?
weapon = {
		state: "doing nuttin",
		ammo: 10,
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

//manage player movement
mvmstate = new SnowState("idle");
//manage player combat
cmbtstate = new SnowState("idle");
//manage player control
cntrlstate = new SnowState("combat");

cntrlstate.add("combat", {
	enter: function() {
		
	},
	step: function() {
		mvmstate.step()
		cmbtstate.step()
	}
})