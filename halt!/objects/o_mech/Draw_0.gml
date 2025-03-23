/// @description Insert description here
// You can write your code in this editor
draw_self()

//draw movement state
draw_text(x, y-20, "chassis: " + string(chassis.durability))
draw_text(x, y-40, "weapon: " + string(weapon.durability))
draw_text(x, y-80, "transport: " + string(transport.durability))