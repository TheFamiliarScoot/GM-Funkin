gpu_set_tex_filter(false);
draw_bg_sprite(sprite_index,image_index,room_width/2,(room_height/2)-200,view_camera[0],7,0.1,0.1);
gpu_set_tex_filter(opt.antialiasing);
event_user(0); // draw characters