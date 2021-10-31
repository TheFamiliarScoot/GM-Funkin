var timer = (cond.gstep * pi) * gfspeed;
var face_x = (x-(1*sclx)) + ((sin(timer)*3)*sclx);
var face_y = (y-(68*scly)) + (abs(sin(timer) * 7)*scly);
var hair_x = (x-(1*sclx)) + ((sin(timer)*3)*sclx);
var hair_y = (y-(72*scly)) + (abs(sin(timer) * 7)*scly);
if hairblow {
	var hair_rot = (cos((timer+1)*8)*4);
}
else {
	var hair_rot = (cos(timer+1)*32);
}
var face_rot = cos(timer+1)*15;
var body_yscale = (1 - (abs(sin(timer+3))* 0.1))*scly;
var body_y = (y-(47*scly)) + (abs(sin(timer) * 4.5)*scly);
var speaker_yscale = (1 - (abs(sin(timer+3))* 0.1))*scly;
var speaker_xscale = (1 + (abs(sin(timer+3))* 0.1))*sclx;

if hairblow {
	draw_sprite_ext(sprites[2],sin(timer*8)+2,hair_x,hair_y,sclx,scly,hair_rot,c_white,1);
}
else {
	draw_sprite_ext(sprites[2],0,hair_x,hair_y,sclx,scly,hair_rot,c_white,1);
}
draw_sprite_ext(sprites[3],0,x,y,speaker_xscale,speaker_yscale,0,c_white,1);
draw_sprite_ext(sprites[0],0,x-(2*sclx),body_y,sclx,body_yscale,0,c_white,1);
draw_sprite_ext(sprites[1],0,face_x,face_y,sclx,scly,face_rot,c_white,1);