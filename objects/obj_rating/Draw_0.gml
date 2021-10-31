draw_self();
draw_set_color(c_black);
draw_text(xstart+49,ystart+50,string(time));
draw_text(xstart+51,ystart+50,string(time));
draw_text(xstart+50,ystart+49,string(time));
draw_text(xstart+50,ystart+51,string(time));
draw_set_color(c_white);
draw_text(xstart+50,ystart+50,string(time));

draw_combo_numbers(numstring,x+180,y+100,0.5);