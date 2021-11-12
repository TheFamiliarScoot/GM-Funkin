draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(0,0,global.view_width,global.view_height,false);
with selections event_perform(ev_draw,0);
draw_set_color(c_white);
draw_set_alpha(1);