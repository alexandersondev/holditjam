#macro mc global.playermech
display_set_gui_size(640,480)

draw_sprite(Sprite14, 0, 0,0)


draw_text(255,43,mc.chassis.durability)
draw_text(260,67,mc.chassis.weight)

draw_text(108,94,mc.weapon.durability)
draw_text(108,116,mc.weapon.damage)
draw_text(108,138,mc.weapon.fire_slowdown)
draw_text(108,155,mc.weapon.weight)

draw_text(108,220,mc.transport.weight)
draw_text(108,247,mc.transport.force)
draw_text(108,267,mc.transport.durability)