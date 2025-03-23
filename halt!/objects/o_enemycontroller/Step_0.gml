/// @description check if dead
if controlledMech.cntrlstate.get_current_state()=="dead"{
	behaviorState.change("dead")	
}
behaviorState.step()
//move enemy along with controller
