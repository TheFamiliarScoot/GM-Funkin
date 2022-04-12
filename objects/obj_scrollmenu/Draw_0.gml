var multX = 90 * scale;
var multY = 180 * scale;
for (var i = 0; i < array_length(choices); i += 1) {
	var notselected = i != selection;
	draw_font_text(choices[i],x+curdrawoffsetX+(i*multX),y+curdrawoffsetY+(i*multY),true,40,scale,false,notselected ? 0.5 : 1);
}