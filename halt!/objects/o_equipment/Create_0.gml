/// @description Insert description here
// You can write your code in this editor
equipment = noone 
type = "notset"

function setup_equipment(_equipment, _type) {
	equipment = _equipment
	type = _type
}

function pickup() {
	instance_destroy();
	return {equipment_data: equipment, item_type: type}	
}